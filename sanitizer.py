
fn = "cicero_ad_catalinam.txt"

f = open(fn)

buf = ""

for ln in f:
    if len(ln) > 50:
        buf += ln.strip()
        buf += " "
    else:
        print buf
        print ln
        buf = ""
