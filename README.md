# Personal Site (Hugo Blox + blogdown)

Source for [https://wangcc.me/](https://wangcc.me/), now running the Hugo Blox Builder framework (Tailwind theme) with custom tweaks including a custom biography block that displays interests and education sections, sticky navigation, back-to-top button, and Formspree contact form. Deployment is handled by GitHub Actions → GitHub Pages.

### Tech Stack

- **Hugo Extended 0.152.2** (pinned in `.Rprofile` for blogdown).
- **Hugo Blox Tailwind modules** vendored under `_vendor/`.
- **Node.js 20 + Tailwind CLI** (installed via `npm ci`) for any future Tailwind customization.
- **R + blogdown** for content authoring when working from RStudio.

### Local Workflow

1. Install dependencies once per clone:

  ```powershell
  npm ci
  ```

  *(blogdown users: `blogdown::install_hugo(version = "0.152.2", extended = TRUE)`)*

2. Preview locally:

  - R workflow: `blogdown::serve_site()`
  - CLI workflow: `hugo server --cleanDestinationDir --disableFastRender`

3. Create/edit content under `content/`, commit, and push. The CI build produces the `public/` artefact—no need to commit it.

### Project Layout (trimmed)

```text
content/                  # Markdown content (posts, gallery, projects, …)
config/_default/          # Hugo config (menus, params, languages, module setup)
assets/                   # Custom media (favicon) + future pipeline assets
blox/                     # Custom Hugo Blox block overrides (resume-biography)
layouts/_partials/hooks/  # Custom head/body hook snippets (sticky nav, back-to-top)
static/                   # Static files served verbatim
_vendor/                  # Hugo Blox modules (checked in for reproducible builds)
scripts/                  # Helper scripts (post generation, env bootstrap)
```

### Custom Enhancements

- `blox/resume-biography/block.html`: custom override of the Hugo Blox resume-biography block that restores legacy Academic theme fields (interests, education) and properly handles `icon_pack` for social media icons.
- `layouts/_partials/hooks/head-end/sticky-header.html`: pins the navbar, widens the biography block, updates footer year, and styles the contact form.
- `layouts/_partials/hooks/body-end/back-to-top.html`: injects the floating "back to top" control.
- `assets/media/icon.png`: restores the legacy favicon used before the theme migration.

### Deployment Notes

- When we merge back to `master`, a GitHub Actions workflow will: `npm ci`, set up Hugo Extended 0.152.2, run `hugo --cleanDestinationDir --minify`, and publish the `public/` output to Pages.
- To guarantee matching local/CI builds, keep `package-lock.json` committed and avoid editing files inside `_vendor/` manually.
- The legacy `public/` folder remains ignored—never commit generated output.

### Content Guidelines

- Daily posts live in `content/post/` (bundle structure supported).
- Front matter should include `title`, `date`, and for proper Hugo Blox compatibility, add `type: post` and `layout: single`.
- Author information is in `content/authors/admin/_index.md` - use `title:` field for name display (not `name:`).
- Social icons require `icon_pack` field (e.g., `fas`, `fab`, `ai`) to display correctly.
- Media belongs inside the same bundle (relative paths stay stable across theme upgrades).

### Maintenance Checklist

- [x] Migrate from legacy Academic theme to Hugo Blox Builder framework.
- [ ] Add/confirm GitHub Actions workflow for Hugo Blox deployment.
- [ ] Retire unused legacy scripts (`deploy.sh`, Netlify remnants) once new pipeline proves stable.
- [ ] Audit Google Analytics integration for GA4 or alternative analytics.
- [ ] Periodically clear `resources/_gen/` (safe to delete, regenerated automatically).

### License

Content © Chaochen Wang. Hugo Blox modules follow the upstream MIT license—see `LICENSE.md` for the base theme license and attribution requirements.
