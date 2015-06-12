if Rails.env ==  "production"
Rack::Timeout.timeout = 600
Rack::Timeout.wait_timeout = 600
end