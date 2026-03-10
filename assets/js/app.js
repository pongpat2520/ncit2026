document.addEventListener('DOMContentLoaded', () => {
    // 1. Smooth Scrolling for Anchor Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                // Offset for the fixed header
                const headerOffset = 80;
                const elementPosition = targetElement.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });

    // 2. Sticky Header Effects
    const header = document.querySelector('header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // 3. Scroll Reveal Animation for Elements
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-up');
                observer.unobserve(entry.target); // Setup once
            }
        });
    }, observerOptions);

    // Initial setup to remove the 'animate-up' class from HTML initially and re-add them when intersecting 
    // This allows elements to natively fade in upon scroll down.
    document.querySelectorAll('.animate-up').forEach((el) => {
        el.style.opacity = '0'; // hide elements init
        el.style.animation = 'none'; // reset animation
        // We will trigger animation manually via intersect
        setTimeout(() => {
           el.style.animation = ''; // remove reset to rely on stylesheet class definition
           observer.observe(el);
        }, 100);
    });

});
