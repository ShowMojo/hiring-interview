class AddTypeToTransaction < ActiveRecord::Migration[6.1]
  def up
    add_column :transactions, :conversion_type, :integer
    # depending on situation, could have written direct sql update command for batches  for faster update if too many records.
    Transaction.find_each do |transaction|
      conversion_type = if transaction.small?
                          :small
                        elsif transaction.large?
                          :large
                        else
                          :extra
                        end
      transaction.update!(conversion_type: conversion_type)
    end
  end

  def down
    remove_column :transactions, :conversion_type
  end
end
