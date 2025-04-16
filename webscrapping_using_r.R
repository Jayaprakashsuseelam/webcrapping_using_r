## R Package
install.packages("rvest")
install.packages("knitr")

library(rvest)
library(knitr)

imdb_url <- "https://www.imdb.com/search/title/?title_type=feature&release_date=2023-01-01,2023-12-31&sort=num_votes,desc"
imdb_page <- read_html(imdb_url)

titles <- imdb_page %>%
  html_nodes(".ipc-title--title a") %>%
  html_text() %>%
  trimws()

ratings <- imdb_page %>%
  html_nodes(".ipc-rating-star--imdb") %>%
  html_attr("aria-label")%>%
  trimws()

rating <- gsub("IMDb rating:", "", ratings)

imdb_data <- data.frame(
  Title = titles,
  Rating = rating
  # Add other columns as needed
)

print("Movie details based on popularity")
kable(imdb_data)


cvt_numeric <- as.numeric(rating[!is.na(as.numeric(rating))])
avg <- mean(cvt_numeric)
print(paste("Average rating of the most populat movies of IMDB website in the year 2023 is : ", avg))
