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

    Refinery::Copywriting::Engine.load_seed
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "copywriting"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/copywriting"})
    end

    drop_table ::Refinery::CopywritingPhrase
  end

end
