class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.references :board

      t.string :law
      t.string :violation
      t.string :card_tid
      t.string :list_tid
      t.string :comment_tid
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps null: false
    end

    add_index :violations, [:board_id, :finished_at]
    add_index :violations, [:card_tid]
  end
end
