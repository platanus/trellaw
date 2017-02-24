class RemoveNotNullFromBoardLawListTid < ActiveRecord::Migration
  def change
    change_column_null :board_laws, :list_tid, true
  end
end
