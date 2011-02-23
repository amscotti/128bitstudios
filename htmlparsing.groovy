@Grab(group='org.ccil.cowan.tagsoup', module='tagsoup', version='1.2' )
def tagsoupParser = new org.ccil.cowan.tagsoup.Parser()
def slurper = new XmlSlurper(tagsoupParser)
def url = "http://www.nfl.com/stats/categorystats?archive=false&conference=null&statisticCategory=PASSING&season=2010&seasonType=REG&experience=null&tabSeq=0&qualified=true&Submit=Go"
def htmlParser = slurper.parse(url)
 
tabledata = htmlParser.'**'.find { it.@class == 'data-table1' }.tbody.tr.collect {
 [
 Rk: it.td[0].text().trim(),
 Player: it.td[1].text().trim(),
 Team: it.td[2].text().trim(),
 Pos: it.td[3].text().trim(),
 Comp: it.td[4].text().trim(),
 Att: it.td[5].text().trim(),
 Pct: it.td[6].text().trim(),
 AttG: it.td[7].text().trim(),
 Yds: it.td[8].text().trim(),
 Avg: it.td[9].text().trim(),
 YdsG: it.td[10].text().trim(),
 TD: it.td[11].text().trim(),
 Int: it.td[12].text().trim(),
 First: it.td[13].text().trim(),
 FirstPercent: it.td[14].text().trim(),
 Lng: it.td[15].text().trim(),
 TwentyPlus: it.td[16].text().trim(),
 FortyPlus: it.td[17].text().trim(),
 Sck: it.td[18].text().trim(),
 Rate: it.td[19].text().trim()
 ]
}
 
tabledata.each { it ->
 println it
}