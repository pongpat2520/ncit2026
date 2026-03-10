$newFooterHtml = @"
    <footer id="contact" style="background-color: var(--bangkok-blue); color: white; padding: 4rem 0 1.5rem; position: relative; overflow: hidden;">
        <div class="container" style="position: relative; z-index: 2;">
            <div class="footer-content" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 3rem; margin-bottom: 3rem;">
                
                <!-- About & Supported By -->
                <div class="footer-section">
                    <h3 style="color: var(--bangkok-gold); font-size: 1.5rem; margin-bottom: 1.5rem; position: relative; padding-bottom: 10px;">InCIT 2026<span style="position: absolute; bottom: 0; left: 0; width: 50px; height: 2px; background-color: var(--bangkok-gold);"></span></h3>
                    <p style="color: rgba(255, 255, 255, 0.8); line-height: 1.8; margin-bottom: 1.5rem;">
                        The 10th International Conference on Information Technology, bringing together researchers, academicians, and professionals to share knowledge and innovations.
                    </p>
                    <div style="display: inline-flex; gap: 1rem; align-items: center; background: rgba(255, 255, 255, 0.05); padding: 1rem; border-radius: 10px; flex-wrap: wrap; margin-top: 1rem;">
                        <img src="img/CITT-PNG-1_n.png" alt="CITT Logo" style="height: 55px; width: auto; object-fit: contain; background: white; padding: 5px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
                        <img src="img/siam.png" alt="Siam University Logo" style="height: 55px; width: auto; object-fit: contain; background: white; padding: 5px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
                        <img src="img/It.jpg" alt="Siam University IT Logo" style="height: 55px; width: auto; object-fit: contain; border-radius: 50%; box-shadow: 0 4px 10px rgba(0,0,0,0.3);">
                    </div>
                </div>

                <!-- Contact Us -->
                <div class="footer-section">
                    <h3 style="color: var(--bangkok-gold); font-size: 1.5rem; margin-bottom: 1.5rem; position: relative; padding-bottom: 10px;">Contact Us<span style="position: absolute; bottom: 0; left: 0; width: 50px; height: 2px; background-color: var(--bangkok-gold);"></span></h3>
                    <div style="color: rgba(255, 255, 255, 0.8); line-height: 1.8;">
                        <p style="margin-bottom: 1.2rem; display: flex; align-items: flex-start;">
                            <i class="fas fa-map-marker-alt" style="color: var(--bangkok-red); font-size: 1.2rem; margin-right: 15px; margin-top: 5px;"></i>
                            <span><strong>InCIT 2026 Secretariat</strong><br>Faculty of Information Technology<br>Siam University, Bangkok, Thailand</span>
                        </p>
                        <p style="margin-bottom: 1.2rem; display: flex; align-items: center;">
                            <i class="fas fa-envelope" style="color: var(--bangkok-gold); font-size: 1.2rem; margin-right: 15px;"></i>
                            <a href="mailto:incit2026@siam.edu" style="color: rgba(255, 255, 255, 0.8); text-decoration: none; transition: color 0.3s;">incit2026@siam.edu</a>
                        </p>
                        <p style="margin-bottom: 0; display: flex; align-items: flex-start;">
                            <i class="fas fa-phone-alt" style="color: #1ea24a; font-size: 1.2rem; margin-right: 15px; margin-top: 5px;"></i>
                            <span>+66 (0) 2-457-0068, 2-867-8000<br>ext. 5130</span>
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="copyright" style="text-align: center; padding-top: 2rem; border-top: 1px solid rgba(255, 255, 255, 0.1); margin-top: 2rem;">
                <p style="color: rgba(255, 255, 255, 0.6); font-size: 0.95rem; margin: 0;">&copy; 2026 InCIT - International Conference on Information Technology. All Rights Reserved.</p>
            </div>
        </div>
    </footer>
"@

$files = Get-ChildItem -Path "d:\Incit2026\Web\incit2026\*.html" -Exclude "index.html"
$regex = '(?s)<footer id="contact" style="background-color: var\(--bangkok-blue\).*?</footer>'

foreach ($file in $files) {
    if ($file.Name -eq "index.html") { continue }
    $content = Get-Content $file.FullName -Raw
    
    if ($content -match $regex) {
        $newContent = [regex]::Replace($content, $regex, $newFooterHtml)
        [IO.File]::WriteAllText($file.FullName, $newContent, [Text.Encoding]::UTF8)
        Write-Output "Updated $($file.Name)"
    } else {
        Write-Output "Skipped $($file.Name) - footer tag not found"
    }
}
