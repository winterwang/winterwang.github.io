library(blogdown)

# Get today's date
today <- Sys.Date()
date_slug <- format(today, "%Y-%m-%d")

# Manually create Chinese weekday to avoid locale issues on Windows
# as.numeric(format(today, "%w")) returns 0 for Sunday, 1 for Monday, etc.
weekday_num <- as.numeric(format(today, "%w")) 
chinese_weekdays <- c("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六")
# We add 1 because R vectors are 1-indexed, but %w starts at 0
weekday_zh <- chinese_weekdays[weekday_num + 1] 

# Construct the final title string
date_title <- paste0(format(today, "%Y年%m月%d日"), " ", weekday_zh)

blogdown::new_post(
  title  = date_title,
  ext    = ".md",
  subdir = "post",
  # The slug will be today's date. You can manually add a short English description
  # for a more descriptive URL, e.g., "2025-11-17-my-daily-thoughts"
  slug   = date_slug,   
  categories = c("Life"),
  tags       = c("日常","記錄","work")
)