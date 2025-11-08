options(
	blogdown.hugo.version = "0.152.2",
	blogdown.server.timeout = 6000
)

prepend_path <- function(path) {
	if (!is.na(path) && nzchar(path) && dir.exists(path)) {
		current_path <- Sys.getenv("PATH")
		if (!grepl(path, current_path, fixed = TRUE)) {
			Sys.setenv(PATH = paste(path, current_path, sep = ";"))
		}
	}
}

# Ensure portable Go (for Hugo Modules) is available in PATH for R/blogdown sessions.
# This avoids the "binary with name 'go' not found in PATH" error when Hugo tries to
# resolve module imports.
local_go_bin <- normalizePath(file.path(".tools", "go", "bin"), winslash = "\\", mustWork = FALSE)
prepend_path(local_go_bin)

# Expose portable Node.js (if installed via setup-go.ps1) so Tailwind/PostCSS work without elevation.
tools_dir <- normalizePath(".tools", winslash = "\\", mustWork = FALSE)
if (dir.exists(tools_dir)) {
	node_dirs <- list.dirs(tools_dir, full.names = TRUE, recursive = FALSE)
	node_dirs <- node_dirs[grepl("^node-v[0-9.]+-win-x64$", basename(node_dirs), perl = TRUE)]
	node_dirs <- node_dirs[file.exists(file.path(node_dirs, "node.exe"))]
	if (length(node_dirs) > 0) {
		info <- file.info(node_dirs)
		selected <- node_dirs[order(info$mtime, decreasing = TRUE)][1]
		selected <- normalizePath(selected, winslash = "\\", mustWork = FALSE)
		prepend_path(selected)
		npm_bin <- normalizePath(file.path(selected, "node_modules", "npm", "bin"), winslash = "\\", mustWork = FALSE)
		prepend_path(npm_bin)
	}
}

# Ensure local npm bin dir (from npm install) is on PATH for tailwindcss, postcss, etc.
local_npm_bin <- normalizePath(file.path("node_modules", ".bin"), winslash = "\\", mustWork = FALSE)
prepend_path(local_npm_bin)

# Prefer vendored modules if present to reduce network + Go dependency at render time.
# Set HUGO_MODULE_VENDOR=1 so Hugo will use the _vendor/ directory if available.
if (dir.exists(normalizePath("_vendor", winslash = "\\", mustWork = FALSE))) {
	Sys.setenv(HUGO_MODULE_VENDOR = "1")
}

# (Optional) If the legacy Academic theme folder still exists but we are migrating to
# Hugo Blox modules, avoid forcing --theme academic. blogdown will add --theme only when
# a theme = value is present in config.toml. We already commented that out, so nothing else to do.
