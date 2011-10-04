class AddPhraseType < ActiveRecord::Migration

  def up
    add_column ::Refinery::CopywritingPhrase, :phrase_type, :string
  end

  def down
    remove_column ::Refinery::CopywritingPhrase, :phrase_type
  end

end
