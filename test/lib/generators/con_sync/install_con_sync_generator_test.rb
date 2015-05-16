require 'test_helper'
require 'generators/install_con_sync/install_con_sync_generator'

module ConSync
  class InstallConSyncGeneratorTest < Rails::Generators::TestCase
    tests InstallConSyncGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
