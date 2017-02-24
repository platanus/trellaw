class AddSettingsToBoardLaw < ActiveRecord::Migration
  def change
    add_column :board_laws, :settings, :text
  end
end
