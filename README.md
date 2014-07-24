streambox-thumbnail-creation-time
=================================

rsync liveus:/c/windows/temp/tmp/extract_frame_time_log.txt .

pdev/lstest/testls/time_extract_frame.pl

ssh liveus du /d/actl3files

* 
```sh
make clean
make t10
grep 172.56.32.125-5896-062514-155431_141 out.txt
```

```sh
 [demo@demos-MacBook-Pro-2:~/pdev/streambox-thumbnail-creation-time(master)]$ grep 172.56.32.125-5896-062514-155431_141 out.txt
3.51 minutes	mplayer c:\Apache\htdocs\ls\actl3files\172.56.32.125-5896-062514-155431_141_th.mov -aid 89 -vo jpeg:quality=90:outdir=3361936918167 -frames 1000	172.56.32.125-5896-062514-155431_141_th.mov	172.56.32.125-5896-062514-155431_141_th
 [demo@demos-MacBook-Pro-2:~/pdev/streambox-thumbnail-creation-time(master)]$
```

So, it takes 3.5 minutes to run this:
```sh
mplayer c:\Apache\htdocs\ls\actl3files\172.56.32.125-5896-062514-155431_141_th.mov -aid 89 -vo jpeg:quality=90:outdir=3361936918167 -frames 1000
```


```sh
wget http://taylors-bucket.s3.amazonaws.com/long-thumbnails/172.56.32.125-5896-062514-155431_141.actl3
```


172.56.32.125-5896-062514-155431_141.actl3 is here: http://liveus.streambox.com/ls/slsfile.php?fid=1486321

```sh
c:\SLS_DB\actl3trans\transcoder.exe  /file c:\Apache\htdocs\ls\actl3files\50.202.229.50-34657-072514-010107_2.actl3 /qt c:\Apache\htdocs\ls\actl3files\50.202.229.50-34657-072514-010107_2_th.mov /mf 1000 1> c:\Apache\htdocs\ls\actl3files\50.202.229.50-34657-072514-010107_2_th.mov.log
C:\Windows\system32\cmd.exe /c c:\SLS_DB\mplayer\mplayer.exe c:\Apache\htdocs\ls\actl3files\50.202.229.50-34657-072514-010107_2_th.mov -aid 89 -vo jpeg:quality=90:outdir=ttt -frames 0 2> c:\Apache\htdocs\ls\actl3files\50.202.229.50-34657-072514-010107_2_th.mov.err
C:\Windows\system32\cmd.exe /c C:\SLS_DB\wrappers\extract_frame.cmd "C:\SLS_DB\wrappers" c:\Apache\htdocs\ls\actl3files\50.202.229.50-8800-072514-011943_5_th.mov c:\Apache\htdocs\ls\actl3files\50.202.229.50-8800-072514-011943_5.jpg 1000
```
