# Hugo Blox Builder - Available Blocks Guide

This guide shows all available blocks in Hugo Blox Builder and how to use them in your `content/_index.md` file.

## Available Blocks

Hugo Blox Builder provides 15+ pre-built blocks you can use:

1. **resume-biography** - Author profile with avatar, interests, education
2. **resume-biography-3** - Alternative biography layout
3. **resume-experience** - Timeline of work experience and education
4. **resume-skills** - Display technical skills with icons and percentages
5. **resume-languages** - Language proficiency display
6. **resume-awards** - Awards and achievements
7. **collection** - Display blog posts, publications, projects
8. **markdown** - Custom markdown content
9. **hero** - Large hero section with CTA buttons
10. **features** - Feature grid with icons
11. **stats** - Statistics/metrics display
12. **cta-card** - Call-to-action card with gradient background
13. **cta-button-list** - Multiple CTA buttons
14. **cta-image-paragraph** - CTA with image and text
15. **testimonials** - Customer/user testimonials

---

## Block Examples with Templates

### 1. Hero Block

Large hero section perfect for landing pages.

```yaml
sections:
  - block: hero
    content:
      title: "Welcome to My Site"
      text: "I'm a researcher passionate about statistical modeling and epidemiology."
      announcement:
        text: "🎉 New paper published!"
        link:
          text: "Read more"
          url: "/publication/my-paper/"
      primary_action:
        text: "Get Started"
        url: "#about"
        icon: "rocket"
      secondary_action:
        text: "View Projects"
        url: "/project/"
    design:
      no_padding: false
```

### 2. Features Block

Showcase features/services with icons.

```yaml
sections:
  - block: features
    content:
      title: "My Research Areas"
      text: "Key areas of expertise and interest"
      items:
        - name: "Bayesian Statistics"
          icon: "chart-line"
          description: "Advanced statistical modeling using Stan and JAGS"
        - name: "Epidemiology"
          icon: "virus"
          description: "Population health and disease prevention studies"
        - name: "Data Science"
          icon: "database"
          description: "Machine learning and data visualization with R/Python"
```

### 3. Stats Block

Display impressive numbers/statistics.

```yaml
sections:
  - block: stats
    content:
      title: "Research Impact"
      text: "By the numbers"
      items:
        - statistic: "50+"
          description: "Publications"
        - statistic: "1000+"
          description: "Citations"
        - statistic: "10+"
          description: "Years Experience"
```

### 4. Resume Experience

Timeline of work and education history.

```yaml
sections:
  - block: resume-experience
    content:
      username: admin  # References content/authors/admin/_index.md
    design:
      date_format: "January 2006"
      is_education_first: false  # Show work experience first
```

**Required in `content/authors/admin/_index.md`:**

```yaml
work:
  - position: "Associate Professor"
    company_name: "Aichi Medical University"
    date_start: "2020-04-01"
    date_end: ""  # Empty means current
    summary: |
      - Teaching biostatistics and epidemiology
      - Conducting research on chronic disease prevention
    icon: "briefcase"  # Optional icon
    button:
      text: "View Department"
      url: "https://university.edu"

education:
  - area: "PhD in Medical Statistics"
    institution: "University Name"
    date_start: "2010-09-01"
    date_end: "2014-08-31"
    summary: "Thesis on Bayesian survival analysis"
    icon: "graduation-cap"
```

### 5. Resume Skills

Display technical skills with proficiency levels.

```yaml
sections:
  - block: resume-skills
    content:
      title: "Technical Skills"
      text: "Tools and technologies I use"
      username: admin
    design:
      columns: 2
      show_skill_percentage: true
```

**Required in `content/authors/admin/_index.md`:**

```yaml
skills:
  - name: "Statistical Analysis"
    color: "#2563eb"
    color_border: "#93c5fd"
    items:
      - name: "R"
        icon: "r-project"
        icon_pack: "fab"
        percent: 95
      - name: "Python"
        icon: "python"
        icon_pack: "fab"
        percent: 80
      - name: "Stan/JAGS"
        icon: "code"
        percent: 85
  
  - name: "Data Visualization"
    items:
      - name: "ggplot2"
        icon: "chart-bar"
        percent: 90
      - name: "D3.js"
        icon: "js"
        icon_pack: "fab"
        percent: 70
```

### 6. CTA Card

Eye-catching call-to-action with gradient background.

```yaml
sections:
  - block: cta-card
    content:
      title: "Ready to Collaborate?"
      text: "I'm always looking for interesting research opportunities and partnerships."
      button:
        text: "Get in Touch"
        url: "#contact"
        icon: "envelope"
    design:
      card:
        css_class: "bg-gradient-to-br from-blue-500 to-purple-600"
        text_color: "light"  # or "dark" or "auto"
        overlay_opacity: 0.15
```

### 7. Testimonials

Display testimonials or recommendations.

```yaml
sections:
  - block: testimonials
    content:
      title: "What Colleagues Say"
      items:
        - text: "Excellent researcher with deep statistical knowledge"
          name: "Dr. Jane Smith"
          role: "Professor, Statistics Department"
          image: "testimonial-1.jpg"  # Place in assets/media/
        - text: "Great collaborator and mentor to students"
          name: "Dr. John Doe"
          role: "Director, Epidemiology Institute"
          image: "testimonial-2.jpg"
```

### 8. Collection Block

Display blog posts, publications, or projects.

```yaml
sections:
  - block: collection
    id: posts
    content:
      title: "Recent Posts"
      page_type: post  # or publication, project
      count: 5  # Number to display, 0 = all
      text: "Check out my latest thoughts on statistics and R programming"
      filters:
        folders:
          - post
        tag: "rstats"  # Optional: filter by tag
        category: "tutorial"  # Optional: filter by category
        exclude_featured: false
    design:
      view: date-title-summary  # or card, compact, citation
      columns: 2
      show_read_more: true
```

**Available view types:**
- `date-title-summary` - List with date, title, summary
- `card` - Card grid layout
- `compact` - Minimal list
- `citation` - Academic citation style (for publications)

### 9. Markdown Block

Add custom HTML/Markdown content.

```yaml
sections:
  - block: markdown
    id: custom-section
    content:
      title: "Custom Content"
      text: |
        ## Heading
        
        Regular **markdown** content with [links](https://example.com).
        
        - Bullet points
        - Work great
        
        You can also include HTML:
        
        <div class="custom-class">
          <p>Custom styling</p>
        </div>
        
        Math equations work too: $E = mc^2$
```

### 10. CTA Button List

Multiple call-to-action buttons.

```yaml
sections:
  - block: cta-button-list
    content:
      title: "Get Started"
      buttons:
        - text: "Download CV"
          url: "/files/cv.pdf"
          icon: "download"
        - text: "View Publications"
          url: "/publication/"
          icon: "book"
        - text: "Contact Me"
          url: "#contact"
          icon: "envelope"
```

### 11. Resume Languages

Display language proficiency.

```yaml
sections:
  - block: resume-languages
    content:
      title: "Languages"
      username: admin
```

**Required in `content/authors/admin/_index.md`:**

```yaml
languages:
  - name: "Japanese"
    proficiency: "Native"
  - name: "English"
    proficiency: "Fluent"
  - name: "Chinese"
    proficiency: "Intermediate"
```

### 12. Resume Awards

Showcase awards and achievements.

```yaml
sections:
  - block: resume-awards
    content:
      title: "Awards & Honors"
      username: admin
```

**Required in `content/authors/admin/_index.md`:**

```yaml
awards:
  - title: "Best Paper Award"
    date: "2023-06-15"
    awarder: "International Statistical Conference"
    summary: "Recognized for innovative Bayesian modeling approach"
  - title: "Teaching Excellence Award"
    date: "2022-03-20"
    awarder: "Aichi Medical University"
```

---

## Design Options

All blocks support these design options:

```yaml
design:
  # Layout
  columns: 2  # 1, 2, 3, 4, 5
  
  # Background
  background:
    color: "#ffffff"
    gradient:
      start: "primary-500"
      end: "primary-700"
    image: "background.jpg"  # From assets/media/
    image_darken: 0.3  # 0-1
  
  # Spacing
  spacing:
    padding: ["20px", "0", "20px", "0"]  # top, right, bottom, left
  
  # CSS
  css_class: "custom-class"
  css_style: "custom: style;"
```

---

## Complete Example: Full Landing Page

Here's a complete `content/_index.md` with multiple blocks:

```yaml
---
title: "Chaochen Wang - Researcher & Educator"
type: landing

sections:
  # Hero section
  - block: hero
    content:
      title: "Statistical Researcher & Epidemiologist"
      text: "Passionate about Bayesian methods and public health"
      primary_action:
        text: "View My Work"
        url: "#publications"
      secondary_action:
        text: "Download CV"
        url: "/files/cv.pdf"
  
  # About section
  - block: resume-biography
    id: about
    content:
      username: admin
    design:
      avatar:
        size: large
        shape: circle
  
  # Skills
  - block: resume-skills
    content:
      title: "Technical Expertise"
      username: admin
    design:
      columns: 3
  
  # Experience timeline
  - block: resume-experience
    content:
      username: admin
    design:
      is_education_first: false
  
  # Stats
  - block: stats
    content:
      items:
        - statistic: "50+"
          description: "Publications"
        - statistic: "1000+"
          description: "Citations"
        - statistic: "15+"
          description: "Years Teaching"
  
  # Recent posts
  - block: collection
    id: posts
    content:
      title: "Latest Posts"
      page_type: post
      count: 5
    design:
      view: card
      columns: 2
  
  # Publications
  - block: collection
    id: publications
    content:
      title: "Recent Publications"
      page_type: publication
      count: 10
    design:
      view: citation
  
  # CTA
  - block: cta-card
    content:
      title: "Let's Collaborate"
      text: "Interested in statistical consulting or research partnerships?"
      button:
        text: "Contact Me"
        url: "#contact"
    design:
      card:
        css_class: "bg-gradient-to-br from-primary-500 to-primary-700"
        text_color: "light"
  
  # Contact form
  - block: markdown
    id: contact
    content:
      title: "Contact"
      text: |
        <form action="https://formspree.io/f/YOUR_ID" method="POST">
          <input type="email" name="email" placeholder="Your email" required />
          <textarea name="message" rows="4" required></textarea>
          <button type="submit">Send</button>
        </form>
---
```

---

## Icon Packs

When using icons, specify the `icon_pack`:

- `fas` - Font Awesome Solid
- `fab` - Font Awesome Brands (github, twitter, etc.)
- `far` - Font Awesome Regular
- `fal` - Font Awesome Light
- `ai` - Academic Icons (google-scholar, orcid, etc.)
- `hero` - Custom SVG icons in `assets/media/icons/hero/`

**Example:**

```yaml
social:
  - icon: github
    icon_pack: fab
    link: https://github.com/username
  - icon: google-scholar
    icon_pack: ai
    link: https://scholar.google.com/
```

---

## Tips

1. **Custom Blocks**: Create your own in `blox/my-block/block.html`
2. **Reusable Content**: Store data in `content/authors/admin/_index.md`
3. **Markdown Support**: Most text fields support markdown formatting
4. **Responsive**: All blocks are mobile-responsive by default
5. **Dark Mode**: Blocks support dark mode automatically

## Resources

- Official Documentation: https://hugoblox.com/blocks/
- Block Templates: `_vendor/github.com/HugoBlox/hugo-blox-builder/modules/blox-tailwind/blox/`
- Your Current Homepage: `content/_index.md`
- Author Profile: `content/authors/admin/_index.md`
