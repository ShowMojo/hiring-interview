class AddTypeToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :type, :integer, null: false, default: 0
  end
end
