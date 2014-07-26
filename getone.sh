fbase=""

while test -z "$fbase"
do
    fbase=$(make lhm | awk '{print $(NF)}' | gshuf | head -1 \
	| sed -e 's,_th$,,')
done

grep $fbase current
grep $fbase calc
