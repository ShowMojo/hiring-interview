class RemoveUidFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :uid, :string
  end
end
