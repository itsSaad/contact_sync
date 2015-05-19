require 'test_helper'
require 'generators/install_contact_sync/install_contact_sync_generator'

module ContactSync
  class InstallContactSyncGeneratorTest < Rails::Generators::TestCase
    tests InstallContactSyncGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
