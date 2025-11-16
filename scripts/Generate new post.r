library(blogdown)

# Get today's date
today <- Sys.Date()
date_slug <- format(today, "%Y-%m-%d")
# Format for title, e.g., "2025年11月16日 星期日"
# Set locale to make sure weekday is in Chinese
Sys.setlocale("LC_TIME", "Chinese")
date_title <- format(today, "%Y年%m月%d日 %A") 

blogdown::new_post(
  title  = date_title,
  ext    = ".md",
  subdir = "post",
  # The slug will be today's date. You can manually add a short English description
  # for a more descriptive URL, e.g., "2025-11-16-my-daily-thoughts"
  slug   = date_slug,   
  categories = c("Life"),
  tags       = c("日常","記錄","work")
)