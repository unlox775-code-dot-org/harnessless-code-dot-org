#
# FileBucket
#
class FileBucket < BucketHelper
  MANIFEST_FILENAME = 'manifest.json'.freeze
  MAXIMUM_FILENAME_LENGTH = 512

  def initialize
    super CDO.files_s3_bucket, CDO.files_s3_directory
  end

  def allowed_file_type?(extension)
    # use Sinatra to get the mime_type
    mime_type = Sinatra::Base.mime_type(extension)

    # and compare it against of our allowed regex-ish strings.
    allowed_mime_regexes = [
      "image/",
      "text/",
      "audio/",
      "video/",
      "application/json",
      "application/ld+json",
      "application/pdf",
      "application/rtf",
    ]

    allowed_mime_regexes.each do |type|
      if Regexp.new(type).match(mime_type)
        return true
      end
    end

    return false
  end

  def get_manifest(channel_id)
    manifest_result = get(channel_id, FileBucket::MANIFEST_FILENAME)
    if manifest_result[:status] == 'NOT_FOUND'
      return []
    end
    JSON.parse(manifest_result[:body].read)
  end

  def copy_files(src_channel, dest_channel, options = {})
    # copy everything except the manifest
    options[:exclude_filenames] = [MANIFEST_FILENAME]
    result = super src_channel, dest_channel, options
    # return right away if there are no files in the source project
    return [] if result.empty?

    # update dest_manifest with the decorated filenames from the src_manifest
    # (we need the new version ids from the dest_manifest, otherwise we'd just copy the src_manifest)
    dest_manifest = JSON.parse result.to_json
    src_manifest = get_manifest(src_channel)
    src_manifest.each do |src_entry|
      src_filename = src_entry['filename']
      dest_manifest.each do |dest_entry|
        if dest_entry['filename'].casecmp?(src_filename)
          dest_entry['filename'] = src_filename
        end
      end
    end

    # Save the dest_manifest in the destination channel
    create_or_replace(dest_channel, FileBucket::MANIFEST_FILENAME, dest_manifest.to_json)

    dest_manifest
  end

  #
  # Generates a direct link to the requested file on s3, with a default 5-minute
  # expiration.
  #
  def make_temporary_public_url(encrypted_channel_id, filename, expires_in = 5.minutes)
    owner_id, storage_app_id = storage_decrypt_channel_id(encrypted_channel_id)
    key = s3_path owner_id, storage_app_id, filename
    Aws::S3::Presigner.new(client: s3).presigned_url(
      :get_object,
      {
        bucket: @bucket,
        key: key,
        expires_in: expires_in.to_i
      }
    )
  end
end
