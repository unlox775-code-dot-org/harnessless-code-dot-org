
module Cdo
  module Metrics
    def self.put(namespace, metric_name, metric_value, dimensions)
      # Stub
    end

    def self.flush!
      # Stub
    end
  end

  class Secrets
    # Constructor
    def initialize(n)
      # Stub
    end

    def required(n = nil)
      # Stub
      print "SECRETS(STUB) required #{n}\n"
    end

    def get!(n)
      # Stub
      print "SECRETS(STUB) get! #{n}\n"
    end
  end
end

class String
  # Returns true if the string ends with the string passed
  def ends_with?(s)
    self[-s.length..] == s
  end

  # Returns true if the string contains any one of the strings passed
  def include_one_of?(*items)
    items.flatten.each do |item|
      return true if include?(item)
    end
    false
  end
end

class Object
  # Returns true if nil or empty (string, array, hash)
  def nil_or_empty?
    nil? || empty?
  end

  # Return the value to use in a querystring/form.
  unless method_defined?(:to_param)  # May be provided by Rails
    def to_param
      to_s
    end
  end

  # Return the value encoded as a querystring/form property (key=value)
  unless method_defined?(:to_query)  # May be provided by Rails
    def to_query(key)
      "#{Rack::Utils.escape(key.to_param)}=#{Rack::Utils.escape(to_param.to_s)}"
    end
  end
end


module Harness
  def error_notify(e, data = {})
    # Stub
  end
end

require 'singleton'

class FirehoseClient
  include Singleton

  def put_record(record,deets)
    # Stub
  end
end

class BucketHelper
  def self.s3_get_object(key, if_modified_since, version)
    # Stub
  end
end