// ==========================================================================
// Mobile Menu Toggle
// ==========================================================================
document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.getElementById('menuToggle');
    const mainMenu = document.getElementById('mainMenu');
    const nav = document.querySelector('nav');
    
    // Toggle mobile menu
    if (menuToggle) {
        menuToggle.addEventListener('click', function() {
            nav.classList.toggle('active');
            this.classList.toggle('active');
        });
    }
    
    // Mobile dropdown functionality
    const dropdowns = document.querySelectorAll('.dropdown > a');
    dropdowns.forEach(dropdown => {
        dropdown.addEventListener('click', function(e) {
            if (window.innerWidth <= 768) {
                e.preventDefault();
                const parent = this.parentElement;
                parent.classList.toggle('active');
                
                // Close other dropdowns
                dropdowns.forEach(other => {
                    if (other !== this) {
                        const otherParent = other.parentElement;
                        otherParent.classList.remove('active');
                    }
                });
            }
        });
    });
    
    // Mobile sub-dropdown functionality
    const subDropdowns = document.querySelectorAll('.dropdown-sub > a');
    subDropdowns.forEach(subDropdown => {
        subDropdown.addEventListener('click', function(e) {
            if (window.innerWidth <= 768) {
                e.preventDefault();
                const parent = this.parentElement;
                parent.classList.toggle('active');
                
                // Close other sub-dropdowns
                subDropdowns.forEach(other => {
                    if (other !== this) {
                        const otherParent = other.parentElement;
                        otherParent.classList.remove('active');
                    }
                });
            }
        });
    });
    
    // Close menu when clicking outside
    document.addEventListener('click', function(e) {
        if (window.innerWidth <= 768) {
            if (!nav.contains(e.target) && !menuToggle.contains(e.target)) {
                nav.classList.remove('active');
                menuToggle.classList.remove('active');
                dropdowns.forEach(dropdown => {
                    dropdown.parentElement.classList.remove('active');
                });
                subDropdowns.forEach(subDropdown => {
                    subDropdown.parentElement.classList.remove('active');
                });
            }
        }
    });
    
    // ==========================================================================
    // Download Button Functionality
    // ==========================================================================
    const downloadButtons = document.querySelectorAll('.btn-download, .btn-download-nav');
    
    downloadButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            // Check if the button already has onclick handler
            if (!this.onclick) {
                e.preventDefault();
                
                // Create download link
                const link = document.createElement('a');
                link.href = 'docs/InCIT2026-CallForPapers.pdf';
                link.target = '_blank';
                link.download = 'InCIT2026-CallForPapers.pdf';
                
                // Add to document and click
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                
                // Optional: Add download tracking
                console.log('PDF download initiated');
                
                // Optional: Show download confirmation
                const originalHTML = this.innerHTML;
                this.innerHTML = '<i class="fas fa-check"></i> Download Started';
                this.disabled = true;
                
                // Reset button after 2 seconds
                setTimeout(() => {
                    this.innerHTML = originalHTML;
                    this.disabled = false;
                }, 2000);
            }
        });
    });
    
    // ==========================================================================
    // Coming Soon Animation
    // ==========================================================================
    const comingSoonElements = document.querySelectorAll('.coming-soon');
    
    comingSoonElements.forEach(element => {
        const icon = element.querySelector('.coming-soon-icon i');
        
        if (icon) {
            element.addEventListener('mouseenter', () => {
                icon.style.animation = 'pulse 1s infinite';
            });
            
            element.addEventListener('mouseleave', () => {
                icon.style.animation = '';
            });
        }
    });
    
    // ==========================================================================
    // Smooth Scroll for Sections
    // ==========================================================================
    const sectionLinks = document.querySelectorAll('a[href^="#"]');
    sectionLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            
            // Check if it's a section link (not #home)
            if (href !== '#home' && href !== '#') {
                e.preventDefault();
                
                const targetId = href.substring(1);
                const targetElement = document.getElementById(targetId);
                
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 80,
                        behavior: 'smooth'
                    });
                    
                    // Close mobile menu if open
                    if (window.innerWidth <= 768) {
                        nav.classList.remove('active');
                        menuToggle.classList.remove('active');
                    }
                }
            }
        });
    });
    
    // ==========================================================================
    // Sticky Header on Scroll
    // ==========================================================================
    let lastScrollTop = 0;
    const header = document.querySelector('header');
    
    window.addEventListener('scroll', function() {
        let scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop > lastScrollTop && scrollTop > 100) {
            // Scrolling down
            header.style.transform = 'translateY(-100%)';
        } else {
            // Scrolling up
            header.style.transform = 'translateY(0)';
        }
        
        lastScrollTop = scrollTop;
    });
    
    // ==========================================================================
    // Animate Elements on Scroll
    // ==========================================================================
    const animateOnScroll = function() {
        const elements = document.querySelectorAll('.download-card, .coming-soon, .date-card, .track-card');
        
        elements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            const elementVisible = 150;
            
            if (elementTop < window.innerHeight - elementVisible) {
                element.classList.add('animated');
            }
        });
    };
    
    window.addEventListener('scroll', animateOnScroll);
    animateOnScroll(); // Initial check
    
    // ==========================================================================
    // Current Year in Footer
    // ==========================================================================
    const yearElement = document.querySelector('.copyright p');
    if (yearElement) {
        const currentYear = new Date().getFullYear();
        yearElement.innerHTML = yearElement.innerHTML.replace('2026', currentYear);
    }
    
    // ==========================================================================
    // Form Submission (if any forms added later)
    // ==========================================================================
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            // Add form submission logic here
            alert('Form submission would be handled here in a real implementation.');
        });
    });
});

// ==========================================================================
// Additional Utility Functions
// ==========================================================================
function downloadPDF() {
    window.open('docs/InCIT2026-CallForPapers.pdf', '_blank');
}

function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        window.scrollTo({
            top: section.offsetTop - 80,
            behavior: 'smooth'
        });
    }
}

function toggleMobileMenu() {
    const nav = document.querySelector('nav');
    const menuToggle = document.getElementById('menuToggle');
    nav.classList.toggle('active');
    menuToggle.classList.toggle('active');
}