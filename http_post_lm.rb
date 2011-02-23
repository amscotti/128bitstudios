require 'net/http'
require 'net/https'
require 'base64'
 
http = Net::HTTP.new('go.netatlantic.com', 82)
http.use_ssl = false
path = '/'
 
# SOAP Envelope
data = <<-EOF
<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope
xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
xmlns:ns1="http://tempuri.org/ns1.xsd"
xmlns:ns="http://www.lyris.com/lmapi">
<SOAP-ENV:Body>
<ns:CreateSingleMember>
<EmailAddress xsi:type="xsd:string">amscotti@128bitstudios.com</EmailAddress>
<FullName xsi:type="xsd:string">Anthony Scotti</FullName>
<ListName xsi:type="xsd:string">mylistname</ListName>
</ns:CreateSingleMember>
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
EOF
 
# Set Headers
headers = {
  'Referer' => 'http://www.128bitstudios.com/',
  'Content-Type' => 'text/xml',
  'Host' => 'go.netatlantic.com',
  'Authorization' => 'Basic ' + Base64::encode64("amscotti@128bitstudios.com:password")
}
 
# Post the request
resp, data = http.post(path, data, headers)
 
# Output
puts 'Code = ' + resp.code
puts 'Message = ' + resp.message
resp.each { |key, val| puts key + ' = ' + val }
puts data