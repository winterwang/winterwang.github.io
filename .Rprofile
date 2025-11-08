options(blogdown.hugo.version = "0.152.2")

# Ensure portable Go (for Hugo Modules) is available in PATH for R/blogdown sessions.
# This avoids the "binary with name 'go' not found in PATH" error when Hugo tries to
# resolve module imports. We prepend only if the directory exists and isn't already in PATH.
local_go_bin <- normalizePath(file.path(".tools", "go", "bin"), winslash = "\\", mustWork = FALSE)
if (dir.exists(local_go_bin) && !grepl(local_go_bin, Sys.getenv("PATH"), fixed = TRUE)) {
	Sys.setenv(PATH = paste(local_go_bin, Sys.getenv("PATH"), sep = ";"))
}

# Prefer vendored modules if present to reduce network + Go dependency at render time.
# Set HUGO_MODULE_VENDOR=1 so Hugo will use the _vendor/ directory if available.
if (dir.exists(normalizePath("_vendor", winslash = "\\", mustWork = FALSE))) {
	Sys.setenv(HUGO_MODULE_VENDOR = "1")
}

# (Optional) If the legacy Academic theme folder still exists but we are migrating to
# Hugo Blox modules, avoid forcing --theme academic. blogdown will add --theme only when
# a theme = value is present in config.toml. We already commented that out, so nothing else to do.
