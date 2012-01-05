module Refinery
  module Copywriting
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery
      engine_name :refinery_copywriting
      
      def self.register(tab)
        tab.name = "copywriting"
        tab.partial = "/refinery/admin/pages/tabs/copywriting"
      end
      
      config.to_prepare do
        require 'refinerycms-pages'
        Refinery::Page.module_eval do
          has_many :copywriting_phrases, :dependent => :destroy
          accepts_nested_attributes_for :copywriting_phrases, :allow_destroy => false
          attr_accessible :copywriting_phrases_attributes
        end
      end
      
      config.to_prepare do
        ::ApplicationController.helper(CopywritingHelper)
      end

      initializer "register refinerycms_copywriting plugin" do |app|
        Refinery::Pages::Tab.register do |tab|
          tab.name = 'copywriting'
          tab.partial = '/refinery/admin/pages/tabs/copywriting'
        end        
        Refinery::Plugin.register do |plugin|
          plugin.name = "refinerycms_copywriting"
          plugin.url = app.routes.url_helpers.refinery_admin_copywriting_phrases_path
          plugin.pathname = root
          plugin.menu_match = /copywriting/
          plugin.activity = {
            :class_name => :'refinery/copywriting_phrase',
            :url => "refinery_admin_copywriting_phrase_path",
            :title => 'name'
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Copywriting)
      end
    end
  end
end
