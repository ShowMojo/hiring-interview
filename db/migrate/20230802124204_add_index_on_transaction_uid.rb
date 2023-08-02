class AddIndexOnTransactionUid < ActiveRecord::Migration[6.1]
  def change
    add_index :transactions, :uid, unique: true
  end
end
