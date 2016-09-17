class AddHamadaToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :user_name, :string
    add_column :payments, :user_number, :integer
    add_column :payments, :user_address, :string
  end
end
