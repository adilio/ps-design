[CmdletBinding()]
param (
    $Path = "$PSScriptRoot\SHOWCASE.md"
)
$preamble = @"
# Sticker Showcase

| Sticker Name | Sticker sample |
| ------------ | -------------- |
"@
New-Item $Path -Force
Add-Content -Value $preamble -Path $Path
$finalDesigns = Get-ChildItem -Recurse -Include *-final.png
foreach ($design in $finalDesigns) {
    $directory = $ExecutionContext.SessionState.Path.NormalizeRelativePath($design.PSParentPath, $PSScriptRoot)
    $image = $ExecutionContext.SessionState.Path.NormalizeRelativePath($design.PSPath, $PSScriptRoot)
    $file = $design.BaseName -replace "-final", ""
    Add-Content -Value "${file}:<a href=`"$directory`"><img src=`"$image`" width=`"25%`"></a>`r`n" -Path $Path
}