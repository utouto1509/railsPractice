class WelcomeController < ApplicationController
  def index
     if current_user
	redirect_to :user_root
	return
     end
  end

  def uto
     puts "welcome uto"
     puts "welcome uto"
     puts "welcome uto"
     puts "welcome uto"
     puts "welcome uto"
     puts "welcome uto"
     puts "welcome uto"
  end
  
end
