#!/usr/bin/env ruby
require 'net/http'
require 'rexml/document'
require 'cgi'
include REXML

begin
  type = {
  	"1" => "Warrior",
  	"2"  => "Paladin",
  	"3"  => "Hunter",       
  	"4"  => "Rogue",
  	"5"  => "Priest",
  	"6"  => "Death Knight",
  	"7"  => "Shaman",
  	"8"  => "Mage",
  	"9"  => "Warlock",
  	"11"  => "Druid"
  }
  type.default = "unknown"
  
  character_list = []

  realm = 'Staghelm'
  guildName = "Controlled Chaos"

  xmlPage = Net::HTTP.start( "www.wowarmory.com").get( "/guild-info.xml?r=#{CGI.escape(realm)}&n=#{CGI.escape(guildName)}",
      {'user-agent' => 'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-GB; rv:1.8.1.4) Gecko/20070515 Firefox/2.0.0.4'})

  odoc = REXML::Document.new xmlPage.body
  odoc.elements.each( '*//character') do |oElement|
     	character = {
  				"name" => oElement.attributes['name'], 
  				"classId" => oElement.attributes['classId'].to_i,
  				"class" => type[oElement.attributes['classId']],
  				"level" => oElement.attributes['level'].to_i,
  				"genderId" => oElement.attributes['genderId'].to_i,
  				"raceId" => oElement.attributes['raceId'].to_i,
  				"achPoints" => oElement.attributes['achPoints'].to_i,
  				"guild" => guildName,
  				"realm" => realm
  		}
      character_list << character
    end

  puts "#{character_list.length} Character Found!"
  puts "-" * 50
  character_list.sort{|a,b| a['name'] <=> b['name']}.each { |character| 
    puts "%-20s%-10s%s" %[character['name'],character['level'],character['class']]
  }
  puts "-" * 50
end