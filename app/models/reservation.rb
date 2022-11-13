class Reservation < ApplicationRecord
  belongs_to :guest
  validates :code, uniqueness: true

  def code_exists?(res_hash)
    if res_hash.dig('reservation') && res_hash.dig('reservation').keys.count == 15
      res_hash.dig('reservation').dig("code").present? 
    else
      res_hash.dig("reservation_code").present? 
    end  
  end

  def check_exists(res_hash)
    if res_hash.dig('reservation') && res_hash.dig('reservation').keys.count == 15
      Reservation.find_by(code: res_hash.dig('reservation').dig("code")) 
    else
      Reservation.find_by(code: res_hash.dig("reservation_code")) 
    end
  end


  def save_payload(res_hash, guest, res_load)

    res = (res_load.present? ? res_load : self) 
    if res_hash.dig('reservation') && res_hash.dig('reservation').keys.count == 15
      res_hash = res_hash.dig('reservation')

      res.attributes.keys.each do |key|
        val = (res_hash.keys.find {|k| k.include?(key) }) 
        if not val
          val = (res_hash.dig("guest_details").keys.find {|k| k.include?(key) }) 
          if val.present?
            res.attributes = {"#{key}": res_hash["guest_details"][val]}  
          end
        else 
          res.attributes = {"#{key}": res_hash[val]}  
        end
      end
      res.total_price = res_hash["total_paid_amount_accurate"]
    else

      res.attributes.keys.each do |key|
        val = (res_hash.keys.find {|k| k.include?(key) }) 
        if val.present?
          res.attributes = {"#{key}": res_hash[val]}  
        end
      end
    end
    if not res_load.present?
      res.attributes = {id: nil, guest_id: guest.id} 
    end

    if res_load.present? 
      res.update(res.attributes.except('id', 'guest_id', 'created_at', 'updated_at')) 
    elsif res.code.present?
      res.save
    else
      false
    end
  end

end
