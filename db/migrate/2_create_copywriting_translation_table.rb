class CreateCopywritingTranslationTable < ActiveRecord::Migration

  def up
    ::Refinery::CopywritingPhrase.create_translation_table!({
        :value => :text
      }, {
        :migrate_data => true
      })
  end

  def down
    ::Refinery::CopywritingPhrase.drop_translation_table! :migrate_data => true
  end

end
