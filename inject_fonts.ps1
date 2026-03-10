$htmlFiles = Get-ChildItem -Path "d:\Incit2026\Web\ncit2026" -Filter "*.html"

$kanitLink1 = '<link rel="preconnect" href="https://fonts.googleapis.com">'
$kanitLink2 = '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
$kanitLink3 = '<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">'

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "index.html") {
        continue
    }

    $content = Get-Content -Path $file.FullName -Raw

    # Check if Kanit is already linked properly
    if ($content -notmatch 'family=Kanit') {
        # Find the end of the <head> section
        $headEndIndex = $content.IndexOf("</head>")
        
        if ($headEndIndex -gt -1) {
            # Check if preconnect exists to avoid duplicates
            if ($content -notmatch 'fonts\.googleapis\.com') {
                $injection = "`r`n    $kanitLink1`r`n    $kanitLink2`r`n    $kanitLink3`r`n"
            } else {
                # Just inject the font link
                $injection = "`r`n    $kanitLink3`r`n"
            }

            $newContent = $content.Insert($headEndIndex, $injection)
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "Injected Kanit font link into $($file.Name)"
        }
    } else {
        Write-Host "Kanit already present in $($file.Name)"
    }
}
