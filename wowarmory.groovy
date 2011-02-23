//Anthony Scotti
//amscotti@128bitstudios.com
 
def realm = URLEncoder.encode("Staghelm")
def guild = URLEncoder.encode("Controlled Chaos")
 
def url = "http://www.wowarmory.com/guild-info.xml?r=${realm}&n=${guild}".toURL()
 
def types = [
"1": "Warrior",    "2": "Paladin",     "3": "Hunter",
"4": "Rogue",      "5": "Priest",      "6": "Death Knight",
"7": "Shaman",     "8": "Mage",        "9": "Warlock",
"11": "Druid"].withDefault { key -> "unknown" }
 
url.openConnection().with {
    setRequestProperty("User-Agent", "Firefox/2.0.0.4")
    inputStream.withReader('UTF-8') { reader ->
        def characters = new XmlSlurper().parse(reader)
        .guildInfo.guild.members.character
        .findAll { it.@level == '80' }
        .collect { [name: it.@name.text(), type: it.@classId.text()] }
        def groupedByType = characters
        .groupBy { it.type }
        println "Total: ${characters.size()} characters found with level 80"
        groupedByType.each { type, avatars ->
            println "\n${avatars.size()} characters of class ${types[type]}"
            avatars.sort { it.name }
            .each { avatar -> println "- ${avatar.name}" }
        }
    }
}