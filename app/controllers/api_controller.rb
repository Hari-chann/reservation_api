class ApiController < ApplicationController

  def record
    saved = false 

    if not params.keys.length > 2 && Guest.new.email_exists?(params) && Reservation.new.code_exists?(params) 
      head(:not_found)
    else
      guest = Guest.new.check_exists(params)
      if not guest
        guest = Guest.new.assign_payload(params)
        saved = (guest.save ? true : false) 
      else 
        saved = true 
      end

      if saved
        res = Reservation.new.check_exists(params) 
        if guest.reservations.new.save_payload(params, guest, res)
          head(:ok)
        else
          head(:not_modified)
        end
      else
        head(:not_modified)
      end
    end
  end

end
