#!/usr/local/bin/pwsh

$SourcePath = "/Users/hermann/Projects/FreeRTOS-Kernel"
$TargetPath = "./src/"

function Copy-SourceFile([System.IO.FileInfo]$File)
{
	$Text = (Get-Content $File -Encoding UTF8)
	$Text = $Text -replace '#include\s+"FreeRTOS\.h"','#include "RP2040_FreeRTOS.h"'
	$Text | Out-File (Join-Path $TargetPath ($File.Name)) -Encoding UTF8
}

Copy-Item "template/*" "$TargetPath/"

dir "$SourcePath/*.c" | ForEach-Object { Copy-SourceFile $_ }
dir "$SourcePath/include/*.h" | ForEach-Object { Copy-SourceFile $_ }

Copy-SourceFile "$SourcePath/portable/MemMang/heap_3.c"

dir "$SourcePath/portable/ThirdParty/GCC/RP2040/*.c" | ForEach-Object { Copy-SourceFile $_ }
dir "$SourcePath/portable/ThirdParty/GCC/RP2040/include/*.h" | ForEach-Object { Copy-SourceFile $_ }
