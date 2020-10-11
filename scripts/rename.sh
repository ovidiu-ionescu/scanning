#!/bin/bash

pref=pg_
# should come from the command line
new_pref="out_"

rename-file() {
  suf=""
  for i in {2..100}
    do
      new_name="$2${suf}.pdf"
      if [[ ! -f ${new_name} ]]; then
        echo ${new_name}
        mv $1 ${new_name}
        return 0
      fi
      suf="-$i"
    done
    echo "Could not find a unique name for $1 $2, skipping" >&2
}


rename -e 's/\s/_/g;' -e 's/\(|\)/#/g;' *.pdf

for f in ${pref}*.pdf
do

dt=$(pdftotext $f - | \
grep -i -E 'januari| februari| maart| april| mei| juni| juli| augustus| september| oktober| november| december' | \
head -1 | \
tr '[:upper:]' '[:lower:]' | \
awk '{ \
m["januari"]=1; \
m["februari"]=2; \
m["maart"]=3; \
m["april"]=4; \
m["mei"]=5; \
m["juni"]=6; \
m["juli"]=7; \
m["augustus"]=8; \
m["september"]=9; \
m["oktober"]=10; \
m["november"]=11; \
m["december"]=12; \
printf("%s-%02d-%02d", $(NF), m[$(NF-1)], $(NF-2)); \
}')

name="${new_pref}${dt}"
#echo $name
rename-file $f $name
done

