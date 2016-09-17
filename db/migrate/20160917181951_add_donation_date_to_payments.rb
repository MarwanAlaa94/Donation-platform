class AddDonationDateToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :donation_date, :string

  end
end
