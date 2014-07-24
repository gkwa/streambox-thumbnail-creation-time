thumb:
	bash -o pipefail -c 'powershell -inputformat none -executionpolicy bypass -noprofile -noninteractive -file create-thumb.ps1'

t10: t9
t10: out.txt
	$(MAKE) t9 | while read f; do echo $$f; cat out.txt | grep $$f; done;

out.txt:
	$(MAKE) t >$@

t9: extract_frame_time_log.txt
t9: current_liveus_list.txt
t9: long_time_files_modified.txt
	grep --file=$< current_liveus_list.txt | grep -iF .actl3 | sed -e 's,\.actl3$$,,'

t8: current_liveus_list.txt
t8: long_time_files_modified.txt
	@grep --file=$< current_liveus_list.txt | grep -iF .actl3

long_time_files_modified.txt: long_time_files.txt
	@sed -e 's,_th$$,,' $< >$@

long_time_files.txt:
	@sh run.sh | sort -n | tail -100 | awk '{print $$11}' >$@

t7: current_liveus_list.txt
	@sh run.sh | sort -n | tail -100 | awk '{print $$11}'

current_liveus_list.txt:
	ssh liveus 'cd /d/actl3files && ls' >$@

t6: extract_frame_time_log.txt
	sh -x run.sh | sort -n | tail -100 | awk '{print $$11}'

t5: extract_frame_time_log.txt
	sh -x run.sh | sort -n | tail -100 | awk '{print $$1,$$11}'

t4: extract_frame_time_log.txt
	sh -x run.sh | sort -n | tail -100

t3: extract_frame_time_log.txt
	sh -x run.sh | head -1000 | sort -n

t2: extract_frame_time_log.txt
	sh -x run.sh | head -1000 | tail -100

t: extract_frame_time_log.txt
	sh run.sh

extract_frame_time_log.txt:
	rsync 'liveus:/c/windows/temp/tmp/extract_frame_time_log.txt' .

clean:
	rm -f current_liveus_list.txt
	rm -f long_time_files.txt
	rm -f long_time_files_modified.txt
	rm -f out.txt
	rm -rf ttt
	rm -f *.mov
	rm -f *.mov.err
	rm -f *.jpg
	rm -f *.log
