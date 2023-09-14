class ChangeCentsColumnsToBigintOnTransactions < ActiveRecord::Migration[6.1]
  def up
    change_column :transactions, :from_amount_cents, :bigint
    change_column :transactions, :to_amount_cents, :bigint
  end

  def down
    change_column :transactions, :from_amount_cents, :integer
    change_column :transactions, :to_amount_cents, :integer
  end
end
