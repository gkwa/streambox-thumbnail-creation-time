$ErrorActionPreference = 'stop'
$WarningPreference = 'stop'
# $PSVersionTable

$cwd = (Get-Location).Path

$actl3_basename="172.56.32.125-5896-062514-155431_141"
$actl3_basename="70.199.138.55-4957-070114-212212_461"

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
