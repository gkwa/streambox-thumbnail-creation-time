t: calc
	grep find calc | sort -nr | head -100

calc: extract_frame_time_log.txt
	perl -w time_extract_frame.pl extract_frame_time_log.txt >$@

thumb:
	bash -o pipefail -c 'powershell -inputformat none -executionpolicy bypass -noprofile -noninteractive -file create-thumb.ps1'

extract_frame_time_log.txt:
	rsync 'liveus:/c/windows/temp/tmp/extract_frame_time_log.txt' .

clean:
	rm -f calc
