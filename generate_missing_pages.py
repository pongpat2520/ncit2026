import os
import glob
import re

html_files = glob.glob('d:/Incit2026/Web/incit2026/*.html')

pages_to_create = {
    'online.html': ('Online Program', 'fas fa-globe'),
    'onsite.html': ('Onsite Program', 'fas fa-map-marker-alt'),
    'camera.html': ('Camera-Ready Instructions', 'fas fa-camera'),
    'sessions.html': ('Regular & Special Sessions', 'fas fa-users'),
    'venue.html': ('Venue', 'fas fa-building'),
    'hotels.html': ('Hotels', 'fas fa-bed'),
    'transport.html': ('Transportation', 'fas fa-bus'),
    'registration.html': ('Registration', 'fas fa-clipboard-list'),
    'program.html': ('Detailed Program', 'fas fa-calendar-alt')
}

# Read presentation.html to extract common header and footer
with open('d:/Incit2026/Web/incit2026/presentation.html', 'r', encoding='utf-8') as f:
    template_content = f.read()

# Extract header (up to </header>)
header_match = re.search(r'(.*?</header>)', template_content, re.IGNORECASE | re.DOTALL)
header_html = header_match.group(1) if header_match else ''

# Extract footer (from <footer)
footer_match = re.search(r'(<footer.*)', template_content, re.IGNORECASE | re.DOTALL)
footer_html = footer_match.group(1) if footer_match else ''

# Function to fix links in nav
def fix_links(html):
    # Fix dropdown parent link for Detailed Program
    html = re.sub(r'<a href="[^"]*">Detailed Program <i class="fas fa-chevron-right"></i></a>',
                  r'<a href="program.html">Detailed Program <i class="fas fa-chevron-right"></i></a>', html)
    # Fix specific links
    html = re.sub(r'href="(index\.html)?#online"', r'href="online.html"', html)
    html = re.sub(r'href="(index\.html)?#onsite"', r'href="onsite.html"', html)
    html = re.sub(r'href="(index\.html)?#camera"', r'href="camera.html"', html)
    html = re.sub(r'href="(index\.html)?#sessions"', r'href="sessions.html"', html)
    html = re.sub(r'href="(index\.html)?#venue"', r'href="venue.html"', html)
    html = re.sub(r'href="(index\.html)?#hotels"', r'href="hotels.html"', html)
    html = re.sub(r'href="(index\.html)?#transport"', r'href="transport.html"', html)
    html = html.replace('href="#" class="btn-register"', 'href="registration.html" class="btn-register"')
    return html

header_html = fix_links(header_html)

for filename, (title, icon) in pages_to_create.items():
    page_content = f"""{header_html}
    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="container">
            <div class="hero-content">
                <h2>{title}</h2>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <section id="content">
            <div class="container">
                <div class="section-title">
                    <h2>{title}</h2>
                </div>
                <div class="coming-soon-container">
                    <div class="coming-soon-content">
                        <div class="coming-soon-icon">
                            <i class="{icon}"></i>
                        </div>
                        <h3>Coming Soon</h3>
                        <p>We are currently preparing information for {title}.</p>
                        <p>Please check back later for more updates.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

{footer_html}
"""
    # Write new page
    with open(f'd:/Incit2026/Web/incit2026/{filename}', 'w', encoding='utf-8') as f:
        f.write(page_content)

# Update all existing HTML files navigation links
for filepath in html_files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = fix_links(content)
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated links in {os.path.basename(filepath)}")
print("Done creating missing pages and updating links!")
