module Refinery
  class CopywritingGenerator < Rails::Generators::Base

    source_root File.expand_path('../../../../', __FILE__)

    def rake_db
      rake("refinery_copywriting:install:migrations")
    end

  end
end
