class AddUuidToTransactions < ActiveRecord::Migration[6.1]
  def up
    add_column :transactions, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    rename_column :transactions, :id, :integer_id
    rename_column :transactions, :uuid, :id
    execute 'ALTER TABLE transactions drop constraint transactions_pkey;'
    execute 'ALTER TABLE transactions ADD PRIMARY KEY (id);'

    # Remove auto-incremented default value for integer_id column
    execute 'ALTER TABLE ONLY transactions ALTER COLUMN integer_id DROP DEFAULT;'
    change_column_null :transactions, :integer_id, true
    execute 'DROP SEQUENCE IF EXISTS transactions_id_seq'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
