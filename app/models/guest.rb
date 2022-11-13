class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :email, uniqueness: true

  def email_exists?(res_hash)
    if res_hash.dig('reservation') && res_hash.dig('reservation').keys.count == 15
      res_hash.dig('reservation').dig("guest_email").present? 
    else
      res_hash.dig("guest").dig('email').present? 
    end  
  end

  def check_exists(res_hash)

    if res_hash.dig('reservation') && res_hash.dig('reservation').keys.count == 15
      res_hash = res_hash.dig('reservation')
      Guest.find_by(email: res_hash.dig("guest_email")) 
    else
      Guest.find_by(email: res_hash.dig("guest").dig('email')) 
    end
  end

  def assign_payload(res_hash)

    if res_hash.dig('reservation') && res_hash.dig('reservation').keys.count == 15
      res_hash = res_hash.dig('reservation')
      self.attributes = {
        email: res_hash['guest_email'],
        first_name: res_hash['guest_first_name'],
        last_name: res_hash['guest_last_name'],
        phones: res_hash['guest_phone_numbers']
      } 
    else
      self.attributes = {
        email: res_hash.dig('guest').dig('email'),
        first_name: res_hash.dig('guest').dig('first_name'),
        last_name: res_hash.dig('guest').dig('last_name'),
        phones: [res_hash.dig('guest').dig('phone')] 
      }
    end

    self
  end


end
