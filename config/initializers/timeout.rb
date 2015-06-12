if Rails.env ==  "production"
Rack::Timeout.wait_timeout = 600
Rack::Timeout.timeout = 600
Rack::Timeout.service_past_wait = true 
Rack::Timeout.wait_overtime = 600
end