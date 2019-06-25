require 'sinatra'
require "httparty"

app_key = 'AVPKBRW3EJMHUBKBT347'

get "/" do
  response = HTTParty.get("https://www.eventbriteapi.com/v3/events/search/?q=#{params[:createria]}&location.address=#{params[:address]}&price=free&token=#{app_key}", format: :plain)
  jsonFile = JSON.parse response, symbolize_names: true
  events = jsonFile.dig(:events)
  eventtitles = []
  describtion = []
  start_date = []
  image = []
  1..15.times do |i|
    event = events[i]
    eventtitles << event.dig(:name,:text)
    describtion << event.dig(:description,:text)
    start_date << event.dig(:start,:local)
    image << event.dig(:logo,:original, :url)
  end

  @allFriend = eventtitles
  @allFriendsPhone =  describtion
  @allFriendsAddress = start_date
  @allFriendsPicture = image
  erb :home
end

get "/skills" do
  erb :skills
end
get "private/main.js" do
  @allFriend = allFriends
  @allFriendsPhone = allFriendsPhone
  @allFriendsAddress = allFriendsAddress
  @allFriendsJob =allFriendsJob
  @allFriendsPicture = allFriendsPicture
end
post "/results" do
  "#{params[:id]} #{rand().to_s.to_a}"
end
