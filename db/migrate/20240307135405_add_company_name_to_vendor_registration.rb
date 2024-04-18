class AddCompanyNameToVendorRegistration < ActiveRecord::Migration[7.0]
  def change
    add_column :vendor_registrations, :company_name, :string
  end
end
