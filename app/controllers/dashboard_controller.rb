class DashboardController < ApplicationController
  def index
  end
  
  def approve
    user_id = params[:user_id]
    url = "https://my.tanda.co/api/v2/timesheets/for/#{user_id}/current?show_costs=true"
    token = "5c8e33cc8db9960d0d6d6fab9c201339c20bbbd15b63706f7d465cc12631c4e9"
    header = {"Authorization" => "Bearer #{token}"}
    
    response = HTTParty.get(url, headers: header).parsed_response

    to_be_approved_shifts = []
    
    response["shifts"].each do |shift|
      schedule_url = "https://my.tanda.co/api/v2/schedules?user_ids=#{shift["user_id"]}&from=#{shift["date"]}&to=#{shift["date"]}&show_costs=true&include_names=false" 
      schedule_response = HTTParty.get(schedule_url, headers: header).parsed_response.first
      
      to_be_approved_shifts << shift if schedule_response["cost"] == shift["cost"]
        
    end
    
    to_be_approved_shifts.each do |shift|
      shift_approved_url = "https://my.tanda.co/api/v2/shifts/#{shift["id"]}"
      body = { status: "APPROVED" }
      
      HTTParty.put(shift_approved_url, headers: header, body: body)
    end

    redirect_to root_path
  end
    
  
end
