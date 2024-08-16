require_relative '../test_helper'
require 'dynamic_config/environment_aware_dynamic_config_helper'

class EnvironmentAwareDynamicConfigHelperTest < Minitest::Test
  def test_create_datastore_cache_logic_on_test
    # By default, unit tests (which this is) use the memory adapter
    assert created_datastore_for_current_environment.is_a? MemoryAdapter

    # If tests detect that they are running in a web application context,
    # they'll instead use DynamoDB to mirror production
    CDO.stubs(:test_system?).returns(true)
    CDO.stubs(:running_web_application?).returns(true)
    assert created_datastore_for_current_environment.is_a? DynamoDBAdapter
  end

  def test_create_datastore_cache_logic_on_production
    # Production uses DynamoDB whether or not the web application is running
    Rails.stubs(:env).returns(:production)
    assert created_datastore_for_current_environment.is_a? DynamoDBAdapter

    CDO.stubs(:running_web_application?).returns(true)
    assert created_datastore_for_current_environment.is_a? DynamoDBAdapter
  end

  def test_create_datastore_cache_logic_default
    # Everything else uses the local filesystem
    Rails.stubs(:env).returns(:development)
    assert created_datastore_for_current_environment.is_a? JSONFileDatastoreAdapter

    Rails.stubs(:env).returns(:unknown)
    assert created_datastore_for_current_environment.is_a? JSONFileDatastoreAdapter
  end

  def test_rack_or_rails_env
    # defaults to test
    assert_equal EnvironmentAwareDynamicConfigHelper.rack_or_rails_env, "test"

    # returns the rack_env if outside of a Rails context
    CDO.stubs(:rack_env).returns(:production)
    assert_equal EnvironmentAwareDynamicConfigHelper.rack_or_rails_env, "production"

    # returns the Rails env if defined
    Rails.stubs(:env).returns(:development)
    assert_equal EnvironmentAwareDynamicConfigHelper.rack_or_rails_env, "development"
  end

  def test_shared_cache_key
    test_env_num = 'expected_test_env_num'
    identifier = 'expected_identifier'

    Object.stub_const :ENV, ENV.to_h.merge!('TEST_ENV_NUMBER' => test_env_num) do
      datastore_cache = EnvironmentAwareDynamicConfigHelper.create_datastore_cache(identifier)
      assert_equal "DynamicConfigData/#{identifier}#{test_env_num}", datastore_cache.shared_cache_key
    end
  end

  # Simple helper method to DRY up the code
  private def created_datastore_for_current_environment
    return EnvironmentAwareDynamicConfigHelper.
        create_datastore_cache('test_create_datastore_cache').
        instance_variable_get(:@datastore)
  end
end
