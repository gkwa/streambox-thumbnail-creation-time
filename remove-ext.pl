# -*- perl -*-

use File::Basename;

$fsansext = fileparse($F[0],(".mov",".actl3",".mp4",".jpg"));
print qq/$fsansext\n/;
