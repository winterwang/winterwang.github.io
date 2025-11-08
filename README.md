# Personal Site (Hugo Blox + blogdown)

Source for [https://wangcc.me/](https://wangcc.me/), now running the Hugo Blox Tailwind theme with a few custom tweaks (sticky navigation, back-to-top button, Formspree contact form). Deployment is handled by GitHub Actions → GitHub Pages.

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
layouts/_partials/hooks/  # Custom head/body hook snippets (sticky nav, back-to-top)
static/                   # Static files served verbatim
_vendor/                  # Hugo Blox modules (checked in for reproducible builds)
scripts/                  # Helper scripts (post generation, env bootstrap)
```

### Custom Enhancements

- `layouts/_partials/hooks/head-end/sticky-header.html`: pins the navbar, widens the biography block, updates footer year, and styles the contact form.
- `layouts/_partials/hooks/body-end/back-to-top.html`: injects the floating “back to top” control.
- `assets/media/icon.png`: restores the legacy favicon used before the theme migration.

### Deployment Notes

- When we merge back to `master`, a GitHub Actions workflow will: `npm ci`, set up Hugo Extended 0.152.2, run `hugo --cleanDestinationDir --minify`, and publish the `public/` output to Pages.
- To guarantee matching local/CI builds, keep `package-lock.json` committed and avoid editing files inside `_vendor/` manually.
- The legacy `public/` folder remains ignored—never commit generated output.

### Content Guidelines

- Daily posts live in `content/post/` (bundle structure supported).
- Front matter should stay minimal: `title`, `date`, optional `tags`/`categories`.
- Media belongs inside the same bundle (relative paths stay stable across theme upgrades).

### Maintenance Checklist

- [ ] Add/confirm GitHub Actions workflow for Hugo Blox deployment.
- [ ] Retire unused legacy scripts (`deploy.sh`, Netlify remnants) once new pipeline proves stable.
- [ ] Audit Google Analytics integration for GA4 or alternative analytics.
- [ ] Periodically clear `resources/_gen/` (safe to delete, regenerated automatically).

### License

Content © Chaochen Wang. Hugo Blox modules follow the upstream MIT license—see `LICENSE.md` for the base theme license and attribution requirements.
