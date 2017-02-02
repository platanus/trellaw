class CreateBoardLaws < ActiveRecord::Migration
  def change
    create_table :board_laws do |t|
      t.references :board, index: true
      t.references :law
      t.string :list_tid, null: false

      t.timestamps null: false
    end
  end
end
