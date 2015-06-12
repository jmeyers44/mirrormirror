if Rails.env ==  "production"
Rack::Timeout.service_timeout = 600
Rack::Timeout.wait_timeout = 600
Rack::Timeout.timeout = 600 
end