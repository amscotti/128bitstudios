require "rubygems"
require "twitter"
require 'geokit'

username = "amscotti"

friends_list = Twitter.friends(username)
friends_list.users.each do |friend|
  puts "----------------------------"
  unless friend.location.nil? || friend.location.strip.empty?
    puts "#{friend.name} AKA #{friend.screen_name} is from #{friend.location}"
    geo = Geokit::Geocoders::YahooGeocoder.geocode(friend.location)
    puts geo.success ? "#{geo.lat}, #{geo.lng}" : "Unable to find Geo for #{friend.location}"
  else
    puts "#{friend.name} AKA #{friend.screen_name} idk where they are from..."
    puts "No listed location"
  end
end