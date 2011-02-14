import java.security.MessageDigest

def digest = MessageDigest.getInstance("MD5")

//Quick MD5 of text
def text = "MD5 this text!"
def md5hash1 = new BigInteger(1,digest.digest(text.getBytes())).toString(16).padLeft(32,"0")

//MD5 of text with updates
digest.update("MD5 ".getBytes())
digest.update("this ".getBytes())
digest.update("text!".getBytes())
def md5hash2 = new BigInteger(1,digest.digest()).toString(16).padLeft(32,"0")

//Output
print "${md5hash1} should be the same as ${md5hash2}"