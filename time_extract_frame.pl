# -*- perl; tab-width: 2; comment-start:"# " -*-
use File::Basename;
use Time::Local;
my $debug=0;

my($file) = $ARGV[0];

open F, "<$file" || die "Can't open $file\n";

my($hour1,$min1,$sec1, $hour2,$min2,$sec2, $command);


while(<F>)
{
    #15:22:22.86 15:22:23.45 "mplayer c:\Apache\htdocs\ls\actl3files\10.0.2.159-2201-021312-152157.mov -aid 89 -vo jpeg:quality=90:outdir=1260428032126 -frames 1"
    ($hour1,$min1,$sec1,$ms1, $hour2,$min2,$sec2,$ms2, $command) = m/(\d+):(\d+):(\d+).(\d+) +(\d+):(\d+):(\d+).(\d+) "(.*)"/;

    if($debug){
        print "\$hour1:$hour1 \$hour2:$hour2\n";
        print "\$min1:$min1 \$min2:$min2\n";
        print "\$sec1:$sec1 \$sec2:$sec2\n";
        print "\$ms1:$ms1 \$ms2:$ms2\n";
        print "\$command:$command\n";
    }


    $hour1 = ($hour1 > 12 ? $hour1 % 12 : $hour1);
    $hour2 = ($hour2 > 12 ? $hour2 % 12 : $hour2);

    $time1 = timelocal($sec1,$min1,$hour1,1,1,2012);
    $time2 = timelocal($sec2,$min2,$hour2,1,1,2012);

    if($debug){
        print "time (minutes):";
    }
    print sprintf("%.2f minutes",int(($time2 - $time1)/60*100)/100);
    print "\t";
    print "$hour1:$min1:$sec1 $hour2:$min2:$sec2";
    print "\t";
    print "$command";
    # 2.70	mplayer c:\Apache\htdocs\ls\actl3files\69.90.235.91-28285-091813-123138_242.mov -aid 89 -vo jpeg:quality=90:outdir=290642563131681 -frames 1000
    if($command =~ m{mplayer}){
        my ($abspath) = ($command =~ /mplayer (\S*) /);
        my ($fname) = ($abspath =~ m{([^\\]*)$});
        print "\t";
        print "$fname";

        ($fnameNoExt) = fileparse($fname,('.mov','actl3','mp4'));
        print "\t";
        print "$fnameNoExt";
    }

    print "\n";
}

close F;
