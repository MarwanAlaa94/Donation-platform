class RemovePhoneNumberFromPayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :user_number
  end
end
