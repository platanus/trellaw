class RemoveLaw < ActiveRecord::Migration
  def up
    drop_table :laws
    remove_column :board_laws, :law_id
    add_column :board_laws, :law, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
