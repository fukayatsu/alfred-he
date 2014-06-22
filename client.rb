require 'uri'
require 'net/https'

command = ARGV.first
unless command
  puts "command not found"
  exit
end

uri = URI.parse(ENV['HE_API_URL'])
http = Net::HTTP.new(uri.host, uri.port)
http.read_timeout = 30
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
request = Net::HTTP::Post.new(uri.request_uri)

request["Authorization"] = ENV['HE_BASIC_AUTH']
request.set_form_data({
  "command" => command
})

response = http.request(request)

if response.code == '200'
  puts "[SUCCESS] #{command} has been sent 🍣"
else
  puts "[FAILURE] #{command} hasn't been sent ☔"
end
