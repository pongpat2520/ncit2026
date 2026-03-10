$ErrorActionPreference = "Stop"
$dir = "d:\Incit2026\Web\ncit2026"
cd $dir

# Create asset directories
New-Item -ItemType Directory -Force -Path "assets\css" | Out-Null
New-Item -ItemType Directory -Force -Path "assets\js" | Out-Null
New-Item -ItemType Directory -Force -Path "assets\img" | Out-Null

$htmlFiles = Get-ChildItem -Filter "*.html"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# Extract from primary index.html
$indexContent = [System.IO.File]::ReadAllText("$dir\index.html", $utf8NoBom)
$stylePattern = '(?i)(?s)<style>(.*?)</style>'
$scriptPattern = '(?i)(?s)<script>(.*?)</script>'

$baseCss = ""
if ($indexContent -match $stylePattern) { $baseCss = $matches[1].Trim() }

$baseJs = ""
if ($indexContent -match $scriptPattern) { $baseJs = $matches[1].Trim() }

$allCss = $baseCss
foreach ($file in $htmlFiles) {
    if ($file.Name -eq "index.html") { continue }
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    if ($content -match $stylePattern) {
        $css = $matches[1].Trim()
        if ($css -ne "" -and $css -ne $baseCss) {
            $allCss += "`n`n/* ========== Styles from $($file.Name) ========== */`n" + $css
        }
    }
}

# Write external files
[System.IO.File]::WriteAllText("$dir\assets\css\style.css", $allCss, $utf8NoBom)
[System.IO.File]::WriteAllText("$dir\assets\js\main.js", $baseJs, $utf8NoBom)

# Update HTML files safely
foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, $utf8NoBom)
    $newContent = $content -replace '(?i)(?s)<style>.*?</style>', '<link rel="stylesheet" href="assets/css/style.css">'
    
    # Check if there is a script to replace
    if ($newContent -match '(?i)(?s)<script>.*?</script>') {
        $newContent = $newContent -replace '(?i)(?s)<script>.*?</script>', '<script src="assets/js/main.js"></script>'
    } else {
        # If no script exists, insert it before </body>
        $newContent = $newContent -replace '(?i)</body>', "<script src=`"assets/js/main.js`"></script>`n</body>"
    }

    [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
}

Write-Output "✅ อัปเดตไฟล์ HTML ทั้งหมดและแยกโฟลเดอร์ assets สำเร็จเรียบร้อยแล้ว!"
