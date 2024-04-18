class HomesController < ApplicationController
  before_action :set_category, only: %i[index media home_design_service]

  def index
    @banner_image = HeaderImage.where(active: true).last
    @blogs_featured = Blog.where(is_featured: true).last(3)
    @blogs_latest = Blog.all_published_data.where.not(
      id: @blogs_featured.pluck(:id)
    ).order('published_dt DESC').first(3)
    @blogs_latest_mobile = Blog.all_published_data.order(
      'published_dt DESC'
    ).last(5)
  end

  def media
    prepare_meta_tags(
      title: "Elan Furnishing in the Spotlight: Media Moments & Design Inspiration",
      description: "Explore Elan Furnishing's media buzz and design inspiration. From magazine features to news articles, witness our home decor journey unfold in the world of design",
      current_url: request.url
    )
  end

  def contact_us
    prepare_meta_tags(
      title: "Get in Touch with Elan Furnishing experts",
      description: "Reach out to Elan Furnishing for personalized home design solutions. Our expert team is ready to assist you in transforming your space",
      current_url: request.url
    )
  end

  def vendor_registration
    prepare_meta_tags(
      title: "Become a Partner: Vendor Registration with Elan Furnishing",
      description: "Join forces with Elan Furnishing. Explore opportunities for vendor registration and become a valued partner today!",
      current_url: request.url
    )
  end

  def faq
    prepare_meta_tags(
      title: "Elan Furnishing FAQ: Answers to Your Home Decor Queries",
      description: "Explore the Elan Furnishing FAQ for solutions to your home decor queries. Find expert advice on fabrics, furniture, accessories, and more, ensuring a seamless and enchanting transformation of your living space",
      current_url: request.url
    )
  end

  def home_design_service
    prepare_meta_tags(
      title: "Elan Furnishing Design Services: Crafting Your Dream Space with Elegance",
      description: "Explore Elan Furnishing's expert design services. Let our team transform your space with a curated selection of fine fabrics, furniture, accessories, and bespoke decor, fully customized to your requirements.",
      current_url: request.url
    )
  end

  def our_story
    prepare_meta_tags(
      title: "Crafting Enchanting Living Spaces with Elegance | Elan Furnishing Story ",
      description: "Explore the essence of Elan Furnishing, where passion meets craftsmanship. Discover our commitment to transforming homes with handpicked treasures",
      current_url: request.url
    )
  end

  def brands
    @brand_categories = BrandCategory.where(
      active: true
    ).order(:priority)

    # setting up the meta tags
    prepare_meta_tags(
      title: "Discover Top-Tier Elegance: Brands Partnered with Elan Furnishing",
      description: "Explore excellence with Elan Furnishing's handpicked brand partners. Uncover a curated selection dedicated to elevating your home decor experience",
      current_url: request.url
    )
  end

  def clientele
    @clientele_image = ClienteleImage.where(
      active: true
    ).order(:priority)

    # setting up the meta tags
    prepare_meta_tags(
      title: "Elan Furnishing's Valued Clientele: Transforming Spaces, Inspiring Lives",
      description: "Join our esteemed clientele and witness the transformative impact of Elan Furnishing's exquisite designs. Explore stories of turning houses into homes",
      current_url: request.url
    )
  end

  def our_services
    # setting up the meta tags
    prepare_meta_tags(
      title: "Elevate Your Space with Our Premium Home Decor Services | Elan Furnishing",
      description: "Discover the comprehensive range of services at Elan Furnishing. From expert design consultations to handpicked treasures.",
      current_url: request.url
    )
  end

  def book_services
    # setting up the meta tags
    prepare_meta_tags(
      title: "Book Expert Design Services with Elan Furnishing",
      description: "Transform your living space with Elan Furnishing's expert design services. Schedule an appointment with our design experts today",
      current_url: request.url
    )
  end

  def nri_homes
    # setting up the meta tags
    prepare_meta_tags(
      title: "Elan Furnishing: Elevating NRI Homes with Timeless Elegance",
      description: "Discover how Elan Furnishing brings timeless elegance to NRI homes. Explore handpicked treasures, expert design services, and top-tier brands",
      current_url: request.url
    )
  end

  def send_inquiry_mail
    name = params['name']
    email = params['email']
    mobile = params['number']

    Inquiry.create(
      name: params['name'],
      email: params['email'],
      mobile: params['number']
    )

    InquiryMailer.send_mail(
      name, email, mobile
    ).deliver_later

    SuccessMailer.send_mail(
      email, name, nil
    ).deliver_later

    head :ok
  end

  def send_contact_mail
    fname = params['fname']
    lname = params['lname']
    email = params['email']
    mobile = params['mobile']
    message = params['message']

    Contact.create(
      first_name: params['fname'],
      last_name: params['lname'],
      email: params['email'],
      mobile: params['mobile'],
      message: params['message']
    )

    ContactMailer.send_mail(
      fname, lname, email, mobile, message
    ).deliver_later

    SuccessMailer.send_mail(
      email, fname, nil
    ).deliver_later

    head :ok
  end

  def send_newsletter_mail
    email = params['email']
    name = params['email']

    Newsletter.create(email: email)

    NewsletterMailer.send_mail(
      email
    ).deliver_later

    NewsletterSuccessMailer.send_mail(
      email
    ).deliver_later

    head :ok
  end

  def send_book_service_mail
    fname = params['fname']
    lname = params['lname']
    email = params['email']
    services = params['services']
    phone = params['phone']
    message = params['message']

    BookService.create(
      first_name: fname,
      last_name: lname,
      email: email,
      service: services,
      phone: phone,
      message: message,
    )

    BookServiceMailer.send_mail(
      fname, lname, email, services, phone, message
    ).deliver_later

    SuccessMailer.send_mail(
      email, fname, nil
    ).deliver_later

    head :ok
  end

  def send_design_service_mail
    name = params['name']
    phone = params['phone']
    email = params['email']
    area = params['area']
    city = params['city']

    DesignService.create(
      name: name,
      phone: phone,
      email: email,
      area: area,
      city: city,
    )

    DesignServiceMailer.send_mail(
      name, phone, email, area, city
    ).deliver_later

    subject = "Hey " + name + ", You've requested a quote!"

    SuccessMailer.send_mail(
      email, name, subject 
    ).deliver_later

    head :ok
  end

  def send_vendor_registration_mail
    puts "===> params: ", params
    fname = params['fname']
    lname = params['lname']
    email = params['email']
    phone = params['phone']
    address = params['address']
    country = params['country']
    company_name = params['company_name']
    image = params['image']

    VendorRegistration.create(
      first_name: fname,
      last_name: lname,
      email: email,
      phone: phone,
      address: address,
      country: country,
      company_name: company_name,
      image: image,
    )

    VendorRegistrationMailer.send_mail(
      fname, lname, email, phone, address, country, company_name
    ).deliver_later

    VendorRegistrationSuccessMailer.send_mail(
      email
    ).deliver_later

    head :ok
  end

  private
    def set_category
      @categories = Category.where(active: true).order(:priority)
    end
end
