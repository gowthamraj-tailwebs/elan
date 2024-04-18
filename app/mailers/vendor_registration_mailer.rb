class VendorRegistrationMailer < ApplicationMailer
    def send_mail(fname, lname, email, phone, address, country)
        info_email = "info@elandecor.in"
        vedika_email = "vedika@tailwebs.com"
        subject = "Elan: New Vendor Registration"

        @fname = fname
        @lname = lname
        @email = email
        @phone = phone
        @address = address
        @country = country
        @company_name = company_name

        mail(to: [info_email, vedika_email], subject: subject)
    end
end
