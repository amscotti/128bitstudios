def entitize(dirty_string) {
    def clean_string = ""
    dirty_string.each { it ->
        def ordcode = it.codePointAt(0)
        if (ordcode > 127){ clean_string += "&#${ordcode};" } else { clean_string += it }
    }
    return clean_string
}