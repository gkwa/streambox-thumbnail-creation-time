fbase=$(make lhm | awk '{print $(NF)}' | gshuf | head -1 \
    | sed -e 's,_th$,,')
grep $fbase current
grep $fbase calc
