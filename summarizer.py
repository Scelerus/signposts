
f = open("results")

rg=[]

rguniq=[]

for ln in f:
    rg.append(ln)
    if not ln in rguniq:
        rguniq.append(ln)

for ln in rguniq:
    print (ln + ": " + str(rg.count(ln)))
    print ""
