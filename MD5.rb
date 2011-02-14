require 'digest/md5'

#Quick MD5 of text
text = "MD5 this text!"
md5hash1 = Digest::MD5.hexdigest(text)

#MD5 of text with updates
m = Digest::MD5.new()
m << "MD5 "
m << "this "
m << "text!"
md5hash2 = m.hexdigest()

#Output
puts "#{md5hash1} should be the same as #{md5hash2}"
