#!/usr/bin/env ruby
require 'net/http'
require 'rexml/document'
include REXML
 
def get_xml_page(strRealm, strGuildName)
 
  oresp = Net::HTTP.start( "www.wowarmory.com") do |http|
    http.get( "/guild-info.xml?r=#{strRealm}&n=#{strGuildName}",
      { 'user-agent' =>
        'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-GB; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4'})
  end
 
  return oresp
end
 
def get_guild_info(xmlPage)
  str_max_level = '80'
  info_array = []
 
  odoc = REXML::Document.new xmlPage.body
  odoc.elements.each( '*//character') do |oElement|
    if oElement.attributes['level'] == str_max_level
      info_array << [oElement.attributes['name'],oElement.attributes['level'], oElement.attributes['classId']]
    end
  end
 
  return info_array
end
 
def get_class_name(classId)
    case classId
        when "1"
            return "Warrior"
        when "2"
            return "Paladin"
        when "3"
            return "Hunter"
        when "4"
            return "Rogue"
        when "5"
            return "Priest"
        when "6"
            return "Death Knight"
        when "7"
            return "Shaman"
        when "8"
            return "Mage"
        when "9"
            return "Warlock"
        when "11"
            return "Druid"
        else
            return "ERROR:#{classId}"
    end
end
 
str_realm = 'Staghelm'
str_guild_name = "Controlled+Chaos"
 
xml_page = get_xml_page(str_realm, str_guild_name)
character_list = get_guild_info(xml_page)
 
puts "#{character_list.length} Character Found!"
puts "-------------------------"
character_list.sort.each { |character| puts "%-20s%-10s%s" %[character[0],character[1],get_class_name(character[2])]}
puts "-------------------------"