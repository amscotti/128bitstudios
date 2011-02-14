import hashlib

#Quick MD5 of text
text = "MD5 this text!"
md5hash1 = hashlib.md5(text).hexdigest()

#MD5 of text with updates
m = hashlib.md5()
m.update("MD5 ")
m.update("this ")
m.update("text!")
md5hash2 = m.hexdigest()

#Output
print("%s should be the same as %s" % (md5hash1, md5hash2))
