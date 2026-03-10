$oldHtml = "                    <h3>Supported By</h3>"

$files = Get-ChildItem -Path "d:\Incit2026\Web\incit2026\*.html"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    if ($content -match "\s*<h3>Supported By</h3>") {
        $newContent = $content -replace " *<h3>Supported By</h3>\r?\n", ""
        [IO.File]::WriteAllText($file.FullName, $newContent, [Text.Encoding]::UTF8)
        Write-Output "Updated $($file.Name)"
    } else {
        Write-Output "Skipped $($file.Name) - pattern not found"
    }
}
