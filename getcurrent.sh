make lhm | \
    awk '{print $(NF)}' | \
    sed -e 's,_th$,,' | \
    sort -u | grep \- | \
    while read f; do 
    grep $f current | grep actl3; done