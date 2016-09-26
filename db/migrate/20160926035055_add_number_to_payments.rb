class AddNumberToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :user_number, :string
  end
end
