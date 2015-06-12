if Rails.env ==  "production"
Rack::Timeout.wait_overtime = 600
Rack::Timeout.service_timeout = 600
Rack::Timeout.timeout = 600 
end