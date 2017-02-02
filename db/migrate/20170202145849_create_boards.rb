class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :user_id, index: true
      t.string :board_tid, null: false
      t.string :webhook_tid

      t.timestamps null: false
    end
  end
end
