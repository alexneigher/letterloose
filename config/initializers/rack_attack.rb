class Rack::Attack
  throttle('req/ip', limit: 50, period: 10.seconds) do |req|
    req.ip
  end
end