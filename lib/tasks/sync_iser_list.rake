require_relative '../../extras/utilities'
include Utilities

namespace :utils do
  desc "Sync ISER staff and students list with The Square"
  task(:sync_iser_list => :environment) do
    sync_iser_list
  end
end
