require 'sinatra'
require 'json'
require 'delighted'

post '/' do
  status 200
  json = JSON.parse(request.body.read)
  if json["event"] == "call.tagged" && json["data"]["tags"][0]["name"] == "CSAT"
    caller_number = json["data"]["raw_digits"].delete(" -")
    Delighted.api_key = ENV["delighted_key"]
    Delighted::Person.create(phone_number: caller_number, channel:"sms")
  end
end
