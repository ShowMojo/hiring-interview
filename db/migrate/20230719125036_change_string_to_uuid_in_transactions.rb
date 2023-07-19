class ChangeStringToUuidInTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :uuid, :uuid, default: 'uuid_generate_v4()', null: false
    change_table :transactions do |t|
      t.remove :uid
      t.rename :uuid, :uid
    end
  end
end
