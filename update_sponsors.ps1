$oldHtml = @"
            <!-- Sponsors & Co-Organized Section -->
        <section id="sponsors-coorganized" style="padding: 4rem 0; background-color: #fff; text-align: center; border-top: 1px solid #eee;">
            <div class="container">
                <div class="section-title">
                    <h2 style="font-size: 2rem;">Sponsored InCIT 2025 & Co-Organized by</h2>
                </div>
                <div style="display: flex; justify-content: center; align-items: center; width: 100%; overflow: hidden; padding-top: 2rem;">
                    <img src="img/footer-1024x149.png" alt="Sponsors and Co-Organizers" style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
                </div>
            </div>
        </section>
"@

$newHtml = @"
        <!-- Sponsored Section -->
        <section id="sponsors"
            style="padding: 4rem 0; background-color: #fff; text-align: center; border-top: 1px solid #eee;">
            <div class="container">
                <div class="section-title">
                    <h2 style="font-size: 2rem;">Sponsored InCIT 2026</h2>
                </div>
                <div
                    style="display: flex; justify-content: center; align-items: center; width: 100%; overflow: hidden; padding-top: 2rem;">
                    <!-- Placeholder for Sponsors -->
                    <p style="color: var(--dark); font-size: 1.1rem; font-weight: 500;">Coming Soon</p>
                </div>
            </div>
        </section>

        <!-- Co-Organized Section -->
        <section id="co-organized"
            style="padding: 4rem 0; background-color: #f8f9fa; text-align: center; border-top: 1px solid #eee;">
            <div class="container">
                <div class="section-title">
                    <h2 style="font-size: 2rem;">Co-Organized by</h2>
                </div>
                <div
                    style="display: flex; justify-content: center; align-items: center; width: 100%; overflow: hidden; padding-top: 2rem;">
                    <img src="img/footer-1024x149.png" alt="Co-Organizers"
                        style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
                </div>
            </div>
        </section>
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
        # Check if the file doesn't have it, we shouldn't insert randomly.
        Write-Output "Skipped $($file.Name) - pattern not found"
    }
}
