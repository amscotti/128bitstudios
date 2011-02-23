listofemails = new File("email_list.txt").text
listofemails.eachLine { it ->
    def respons = new XmlSlurper().parseText(new URL("http://www.stopforumspam.com/api?email=${it}").text)
    if (respons.appears.text() == "yes") {
        println "${it} has been reported ${respons.frequency.text()} times on stopforumspam.com"
    }
 }