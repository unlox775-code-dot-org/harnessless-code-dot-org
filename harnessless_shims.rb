
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

module Harness
  def error_notify(e, data = {})
    # Stub
  end
end

class BucketHelper
  def self.s3_get_object(key, if_modified_since, version)
    # Stub
  end
end