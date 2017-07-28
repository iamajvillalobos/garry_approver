
[1mFrom:[0m /home/ubuntu/workspace/app/controllers/dashboard_controller.rb @ line 15 DashboardController#approve:

     [1;34m5[0m: [32mdef[0m [1;34mapprove[0m
     [1;34m6[0m:   user_id = params[[33m:user_id[0m]
     [1;34m7[0m:   url = [31m[1;31m"[0m[31mhttps://my.tanda.co/api/v2/timesheets/for/#{user_id}[0m[31m/current[1;31m"[0m[31m[0m
     [1;34m8[0m:   token = [31m[1;31m"[0m[31m2da78e06e556e1bb2021747f4d9c12ebda620c3c95aa0123a0b7da075d7814c4[1;31m"[0m[31m[0m
     [1;34m9[0m:   header = {[31m[1;31m"[0m[31mAuthorization[1;31m"[0m[31m[0m => [31m[1;31m"[0m[31mBearer #{token}[0m[31m[1;31m"[0m[31m[0m}
    [1;34m10[0m: 
    [1;34m11[0m:   response = [1;34;4mHTTParty[0m.get(url, [35mheaders[0m: header).parsed_response
    [1;34m12[0m:   
    [1;34m13[0m:   to_be_approved_shifts = []
    [1;34m14[0m:   
 => [1;34m15[0m:   binding.pry
    [1;34m16[0m:   
    [1;34m17[0m:   response.each [32mdo[0m |shift|
    [1;34m18[0m:     [1;34m# we get the schedule of each shift[0m
    [1;34m19[0m:     [1;34m# we compare the cost[0m
    [1;34m20[0m:     [1;34m# the cost with 0 difference we add to an outside array[0m
    [1;34m21[0m:   [32mend[0m
    [1;34m22[0m:   
    [1;34m23[0m:   schedule_url = [31m[1;31m"[0m[31mhttps://my.tanda.co/api/v2/schedules?user_ids=#{user_id}[0m[31m&from=2017-07-25&to=2017-07-25&show_costs=true&include_names=false[1;31m"[0m[31m[0m 
    [1;34m24[0m:   
    [1;34m25[0m:   schedule_response = [1;34;4mHTTParty[0m.get(schedule_url, [35mheaders[0m: header)
    [1;34m26[0m:   
    [1;34m27[0m:   binding.pry
    [1;34m28[0m: [32mend[0m

