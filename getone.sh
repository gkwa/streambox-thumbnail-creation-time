c=""
fbase=""

test ! -s current && exit
test ! -s calc && exit

while test -z "$c"
do
    fbase=$(make list_heavy_mplayer_commands \
	| awk '{print $(NF)}' | gshuf | head -1 \
	| sed -e 's,_th$,,')
    c=$(grep $fbase current)
    echo checking $fbase
done

grep $fbase current
grep $fbase calc
