require 'refinerycms-core'

module Refinery
  module Copywriting
    class Engine < Rails::Engine
      config.to_prepare do
        Refinery::Page.module_eval do
          has_many :copywriting_phrases, :dependent => :destroy
          accepts_nested_attributes_for :copywriting_phrases, :allow_destroy => false
          attr_accessible :copywriting_phrases_attributes
        end
      end

      config.to_prepare do
        ::ApplicationController.helper(CopywritingHelper)
      end

      initializer "init plugin", :after => :set_routes_reloader do |app|
        Refinery::Pages::Tab.register do |tab|
          tab.name = 'copywriting'
          tab.partial = '/refinery/admin/pages/tabs/copywriting'
        end
        Refinery::Plugin.register do |plugin|
          plugin.name = 'refinerycms_copywriting'
          plugin.url = app.routes.url_helpers.refinery_admin_copywriting_phrases_path
          plugin.menu_match = /copywriting/
          plugin.activity = {
            :class => Refinery::CopywritingPhrase,
            :title => 'name'
          }
        end
      end
    end
  end
end
