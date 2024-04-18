# == Schema Information
#
# Table name: vendor_registrations
#
#  id           :bigint           not null, primary key
#  address      :text(65535)
#  company_name :string(255)
#  country      :string(255)
#  email        :string(255)
#  first_name   :string(255)
#  image_data   :text(65535)
#  last_name    :string(255)
#  phone        :string(255)
#  status       :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class VendorRegistration < ApplicationRecord
    include ImageUploader::Attachment(:image)
end
