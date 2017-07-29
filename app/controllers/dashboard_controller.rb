class DashboardController < ApplicationController
  
  @@token = "87a45657ebf9408587ae7f01501f68921382d553ba540b97eca59914d330f453"
  @@header = {"Authorization" => "Bearer #{@@token}"}
  def index
  end
  
  def find_users_with_timesheets
    url = "https://my.tanda.co/api/v2/timesheets/current?show_costs=true&show_award_interpretation=false"
    
    current_timesheets = HTTParty.get(url, headers: @@header).parsed_response
    
    @current_users = []
    current_timesheets.each do |timesheet|
      @current_users << timesheet["user_id"]
    end
  end
  
  def 
  
  def approve
    user_id = params[:user_id]
    url = "https://my.tanda.co/api/v2/timesheets/for/#{user_id}/current?show_costs=true"
    token = "87a45657ebf9408587ae7f01501f68921382d553ba540b97eca59914d330f453"
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
