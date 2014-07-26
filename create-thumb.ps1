$ErrorActionPreference = 'stop'
$WarningPreference = 'stop'
# $PSVersionTable

$cwd = (Get-Location).Path

$actl3_basename="172.56.32.125-5896-062514-155431_141"

# 6.61 minutes	12:28:19 12:34:56	mplayer c:\Apache\htdocs\ls\actl3files\166.137.212.30-33040-070114-122720_374_th.mov -aid 89 -vo jpeg:quality=90:outdir=1424743446956 -frames 1000	166.137.212.30-33040-070114-122720_374_th.mov	166.137.212.30-33040-070114-122720_374_th
$actl3_basename="166.137.212.30-33040-070114-122720_374"

# 3.90 minutes	9:23:04 9:26:58	mplayer c:\Apache\htdocs\ls\actl3files\70.199.138.55-4957-070114-212212_461_th.mov -aid 89 -vo jpeg:quality=90:outdir=207222727918905 -frames 1000	70.199.138.55-4957-070114-212212_461_th.mov	70.199.138.55-4957-070114-212212_461_th
$actl3_basename="70.199.138.55-4957-070114-212212_461"

# 5.46 minutes	4:02:42 4:08:10	mplayer c:\Apache\htdocs\ls\actl3files\69.90.235.91-14591-062514-155936_142_th.mov -aid 89 -vo jpeg:quality=90:outdir=1776805631947 -frames 1000	69.90.235.91-14591-062514-155936_142_th.mov	69.90.235.91-14591-062514-155936_142_th
# Elapsed Time: 3 minutes
$actl3_basename="69.90.235.91-14591-062514-155936_142"

# 4.16 minutes	1:50:35 1:54:45	mplayer c:\Apache\htdocs\ls\actl3files\172.56.32.75-30766-071514-131930_921_th.mov -aid 89 -vo jpeg:quality=90:outdir=154862914428332 -frames 1000	172.56.32.75-30766-071514-131930_921_th.mov	172.56.32.75-30766-071514-131930_921_th
# Elapsed Time: 4 minutes
$actl3_basename="172.56.32.75-30766-071514-131930_921"

# 4.18 minutes	8:43:00 8:47:11	mplayer c:\Apache\htdocs\ls\actl3files\50.202.229.50-17873-070214-203821_651_th.mov -aid 89 -vo jpeg:quality=90:outdir=102157387731 -frames 1000	50.202.229.50-17873-070214-203821_651_th.mov	50.202.229.50-17873-070214-203821_651_th
# Elapsed Time: 4 minutes
$actl3_basename="50.202.229.50-17873-070214-203821_651"

$actl3_basename="166.137.214.170-42268-062814-205420_183"
# 15.56 minutes	8:58:20 9:13:54	mplayer c:\Apache\htdocs\ls\actl3files\166.137.214.170-42268-062814-205420_183_th.mov -aid 89 -vo jpeg:quality=90:outdir=21406158525088 -frames 1000	166.137.214.170-42268-062814-205420_183_th.mov	166.137.214.170-42268-062814-205420_183_th

$actl3_sourcedir="c:\Apache\htdocs\ls\actl3files"
$actl3_sourcedir="$cwd\long-thumbnails"

$actl3_fname="$actl3_basename.actl3"

$transcoder_output_basename="$actl3_basename"
$transcoder_output_fname="$transcoder_output_basename.mov"
$transcoder_output_dir="$cwd"

$mov_basename="$actl3_basename"
$mov_fname="$mov_basename.mov"
$mov_sourcedir="$cwd"
$mov_output_abspath="$cwd\$mov_fname"

$mov_logfile_basename="$mov_basename"
$mov_logfile_fname="$mov_logfile_basename.log"
$mov_logfile_outdir="$cwd"

$mplayer_logfile_outdir="$cwd"
$mplayer_log_basename = "$mov_fname"
$mplayer_log_fname = "$mov_fname.err"
$mplayer_logfile_outdir="$cwd"

$jpeg_basename="$actl3_basename"
$jpeg_fname="$jpeg_basename.jpg"
$jpeg_outdir="$cwd"

##################################################
# calculated vars
##################################################

$actl3_abspath="$actl3_sourcedir\$actl3_fname"
$mov_abspath="$transcoder_output_dir\$mov_fname"
$mov_logfile_abspath="$mov_logfile_outdir\$mov_logfile_fname"
$mplayer_logfile_abspath="$mplayer_logfile_outdir\$mplayer_log_fname"
$jpeg_abspath="$jpeg_outdir\$jpeg_fname"
$transcoder_output_abspath="$transcoder_output_dir\$transcoder_output_fname"

sv startDTM -value (Get-Date) -option constant

##################################################
# Generate MOV
##################################################

for ($i=1; $i -le 4; $i++)
{
    if(test-path "$mov_output_abspath")
    {
	"{0:N2}" -f ((Get-item $mov_output_abspath).length/1kb) + " KB" | Out-String
	if(1000 -lt (Get-item $mov_output_abspath).length/1kb)
	{
	    break
	}
    }

    & "c:\SLS_DB\actl3trans\transcoder.exe" "/file" "$actl3_abspath" "/qt" "$transcoder_output_abspath" "/mf" "1000" >$mov_logfile_abspath
    @"
"c:\SLS_DB\actl3trans\transcoder.exe" "/file" "$actl3_abspath" "/qt" "$transcoder_output_abspath" "/mf" "1000" >$mov_logfile_abspath
"@
}

if(!(test-path "$mov_output_abspath"))
{
    Write-Host "$mov_output_abspath couldnt be found"
    Exit 1
}


##################################################
# Check if mov has audio
##################################################

if(!(test-path "$cwd\ttt"))
{
    $result = new-item -Path "$cwd\ttt" -ItemType Directory
}

try
{

    @"
"c:\SLS_DB\mplayer\mplayer.exe" "$mov_abspath" "-aid" "89" "-vo" "jpeg:quality=90:outdir=ttt" "-frames" "0" 2>$mplayer_logfile_abspath
"@
    & "c:\SLS_DB\mplayer\mplayer.exe" "$mov_abspath" "-aid" "89" "-vo" "jpeg:quality=90:outdir=ttt" "-frames" "0" 2>$mplayer_logfile_abspath

} catch {}


##################################################
# Extract jpeg images
##################################################

& "cmd" "/c" "C:\SLS_DB\wrappers\extract_frame.cmd" "C:\SLS_DB\wrappers" "$mov_abspath" $jpeg_abspath 1000

$ts = new-timespan -minutes $(((Get-Date)-$startDTM).TotalMinutes)

"Elapsed Time: {0}" -f $(if($ts.hours -lt 1){"{0} minutes" `
  -f $ts.minutes}else{"{0} hours, {1} minutes" -f $ts.hours, $ts.minutes})
