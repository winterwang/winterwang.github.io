# Interactive script to create a new gallery post for a Hugo site.

# --- Instructions ---
# 1. Place your new image file inside the `static/gallery/` directory.
#    For example: `static/gallery/2025/my-new-photo.jpg`
# 2. Run this script from the root of your project in R or RStudio.
# 3. Answer the prompts for the title and the image path.
# ---

# Function to create a URL-friendly slug from a title
create_slug <- function(title) {
  slug <- tolower(title)
  slug <- gsub(" ", "-", slug)
  slug <- gsub("[^a-z0-9-]", "", slug)
  slug <- gsub("-+", "-", slug)
  slug <- sub("-$", "", slug)
  return(slug)
}

# 1. Get user input
cat("--- New Gallery Post ---\n")
post_title <- readline(prompt = "Enter the title/caption for your photo: ")
image_path_input <- readline(prompt = "Enter the image path (relative to 'static/gallery/', e.g., '2025/my-photo.jpg'): ")

if (post_title == "" || image_path_input == "") {
  stop("Title and image path cannot be empty. Aborting.")
}

# 2. Prepare front matter fields
# Use current time, formatted as required by Hugo (RFC3339)
date_rfc3339 <- format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z")

# Create a clean filename for the markdown file
slug <- create_slug(post_title)
md_filename <- paste0(format(Sys.Date(), "%Y-%m-%d"), "-", slug, ".md")
md_filepath <- file.path("content", "gallery", md_filename)

# Format the image path for the front matter
image_front_matter_path <- paste0("gallery/", image_path_input)

# 3. Create the file content
file_content <- paste(
  "---",
  paste0('title: "', post_title, '"'),
  paste0("date: ", date_rfc3339),
  paste0('image: "', image_front_matter_path, '"'),
  paste0('thumb: "', image_front_matter_path, '"'),
  "---",
  "",
  sep = "\n"
)

# 4. Write the new markdown file
if (file.exists(md_filepath)) {
  stop("A file with this name already exists. Aborting to prevent overwriting.")
} else {
  writeLines(file_content, md_filepath)
  cat("\nSuccess! ✨\n")
  cat(paste("Created new gallery post at:", md_filepath, "\n"))
}
