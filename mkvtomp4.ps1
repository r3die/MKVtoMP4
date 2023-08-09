$Top_Folder = ""
#Put location of Top Folder within Quotes on line 1
$Child_Folders = Get-ChildItem -Path $Top_Folder -Recurse |where-Object {$_.PSIsContainer -eq $true }

foreach ($foldername in $child_folders.Fullname) 
{
cd $foldername
If ((Test-Path *.mp4) -And (Test-path *.mkv)) {Write-host "Skip, Folder has been processed."}
ElseIf ((Test-Path *.mkv) -eq $False) {Write-host "Skip, No video to process"}
ElseIf (Test-Path *.mkv) {
start-process "C:\scripts\videomerge.bat" -wait
start-process "C:\scripts\videoconvert.bat" -wait


#Taking the name from one of the files in the combine file
(Get-Content .\combine.txt| ForEach-Object {$_ -replace "file",""}|
ForEach-Object {$_ -replace "'",""} | ForEach-Object {$_ -replace ".mkv",".mp4"} |
Out-File .\convert2.txt)

#changing name of final output .mp4
$rename = get-item -path .\convert2.txt | get-content -tail 1
ren output.mp4 $rename

#cleaning up folder and moving .mp4 output
remove-item .\combine.txt
remove-item .\convert2.txt
remove-item .\output.mkv
copy-item .\*.mp4 -destination "C:\Destination"
}
}
