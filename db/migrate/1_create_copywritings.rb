class CreateCopywritings < ActiveRecord::Migration

  def up
    create_table ::Refinery::CopywritingPhrase.table_name do |t|
      t.string :name
      t.text :default
      t.text :value
      t.string :scope
      t.integer :page_id

      t.timestamps
    end

    add_index ::Refinery::CopywritingPhrase, [:name, :scope]

    load(Rails.root.join('db', 'seeds', 'copywritings.rb'))
  end

  def down
    ::Refinery::UserPlugin.destroy_all({:name => "refinerycms_copywriting"})

    drop_table ::Refinery::CopywritingPhrase
  end

end
