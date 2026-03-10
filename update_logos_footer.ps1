$oldHtml = @"
                <div class="footer-section">
                    <h3>Contact Us</h3>
"@

$newHtml = @"
                <!-- Supported By Section (Bottom Left Logos) -->
                <div class="footer-section" style="max-width: 350px;">
                    <h3>Supported By</h3>
                    <div style="display: flex; gap: 1rem; align-items: center; background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 10px; flex-wrap: wrap;">
                        <img src="img/CITT-PNG-1_n.png" alt="CITT Logo" style="height: 65px; width: auto; object-fit: contain; background: white; padding: 5px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
                        <img src="img/It.jpg" alt="Siam University IT Logo" style="height: 65px; width: auto; object-fit: contain; border-radius: 50%; box-shadow: 0 4px 10px rgba(0,0,0,0.3);">
                    </div>
                </div>

                <div class="footer-section">
                    <h3>Contact Us</h3>
"@

$files = Get-ChildItem -Path "d:\Incit2026\Web\incit2026\*.html" -Exclude "index.html"
foreach ($file in $files) {
    if ($file.Name -eq "index.html") { continue }
    $content = Get-Content $file.FullName -Raw
    
    $cleanContent = $content -replace "`r`n", "`n"
    $cleanOldHtml = $oldHtml -replace "`r`n", "`n"
    $cleanNewHtml = $newHtml -replace "`r`n", "`n"

    $newContent = $cleanContent.Replace($cleanOldHtml, $cleanNewHtml)
    
    if ($newContent -ne $cleanContent) {
        $newContent = $newContent -replace "`n", "`r`n"
        [IO.File]::WriteAllText($file.FullName, $newContent, [Text.Encoding]::UTF8)
        Write-Output "Updated $($file.Name)"
    } else {
        Write-Output "Skipped $($file.Name) - pattern not found"
    }
}
