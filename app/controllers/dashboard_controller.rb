class DashboardController < ApplicationController
  
  @@token = "75a962dd1f0e3bdae3abc5ef4bcb91fa41ee7f1b43f87de9dca575cee640d692"
  @@header = {"Authorization" => "Bearer #{@@token}", "X-Tanda-Audit-Name" => "Gazza"}
  def index
  end
  
  def find_users_with_timesheets
    url = "https://staging.tanda.co/api/v2/timesheets/current?show_costs=true&show_award_interpretation=false"
    
    current_timesheets = HTTParty.get(url, headers: @@header).parsed_response
    
    @current_users = []
    current_timesheets.each do |timesheet|
      @current_users << timesheet["user_id"]
    end
    check_timesheet(@current_users)
  end
  
  def check_timesheet(user_list)
    user_list.each do |user|
      approve(user)
    end
    redirect_to 'https://staging.tanda.co/timesheets'
  end
  
  def approve(user)
    user_id = user
    url = "https://staging.tanda.co/api/v2/timesheets/for/#{user_id}/current?show_costs=true"
    
    response = HTTParty.get(url, headers: @@header).parsed_response

    to_be_approved_shifts = []
    
    response["shifts"].each do |shift|
      schedule_url = "https://staging.tanda.co/api/v2/schedules?user_ids=#{shift["user_id"]}&from=#{shift["date"]}&to=#{shift["date"]}&show_costs=true&include_names=false" 
      schedule_response = HTTParty.get(schedule_url, headers: @@header).parsed_response.first
      unless schedule_response.nil?
      
      to_be_approved_shifts << shift if schedule_response["cost"] == shift["cost"]
      end
    
    to_be_approved_shifts.each do |shift|
      shift_approved_url = "https://staging.tanda.co/api/v2/shifts/#{shift["id"]}"
      body = { status: "APPROVED" }
      
      HTTParty.put(shift_approved_url, headers: @@header, body: body)
    end
    end
    
  
  end
    

end
