class DashboardController < ApplicationController
  def index
  end
  
  def approve
    user_id = params[:user_id]
    url = "https://my.tanda.co/api/v2/timesheets/for/#{user_id}/current"
    token = "2da78e06e556e1bb2021747f4d9c12ebda620c3c95aa0123a0b7da075d7814c4"
    header = {"Authorization" => "Bearer #{token}"}
    
    response = HTTParty.get(url, headers: header)
    
  end
  
end
