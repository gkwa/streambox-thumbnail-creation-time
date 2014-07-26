getone: calc
getone: current
	sh getone.sh

heavy: list_heavy_mplayer_commands
lhm: list_heavy_mplayer_commands
list_heavy_mplayer_commands: calc
	sort -n calc | tail -100 | grep ^3 -A 100

current:
	ssh liveus "cd /d/actl3files && ls" >current

lhf: list_heavy_find_commands
list_heavy_find_commands: calc
	grep find calc | sort -nr | head -100

calc: extract_frame_time_log.txt
	perl -w time_extract_frame.pl extract_frame_time_log.txt >$@

thumb:
	bash -o pipefail -c 'powershell -inputformat none -executionpolicy bypass -noprofile -noninteractive -file create-thumb.ps1'

extract_frame_time_log.txt:
	rsync 'liveus:/c/windows/temp/tmp/extract_frame_time_log.txt' .

clean:
	rm -f calc
	rm -f current
