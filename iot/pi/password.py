import crypt
import getpass

PASS = getpass.getpass()

hashed = crypt.crypt(PASS, crypt.mksalt(crypt.METHOD_SHA512))

print(hashed)
