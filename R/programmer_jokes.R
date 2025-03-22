library(httr)
library(jsonlite)
library(ggplot2)
library(stringr)  # For string manipulation

progr_joke_img <- function() {
  url <- "https://v2.jokeapi.dev/joke/Programming?type=single"

  response <- GET(url)

  # Check if API call was successful
  if (status_code(response) != 200) {
    stop("Failed to fetch joke from API")
  }

  joke_data <- fromJSON(content(response, "text", encoding = "UTF-8"))

  # Handle different API responses (some have "joke", some have "setup")
  joke <- ifelse("joke" %in% names(joke_data), joke_data$joke, joke_data$setup)

  # Split joke into smaller parts if it's too long
  max_width <- 60  # Max characters per line
  wrapped_joke <- str_wrap(joke, width = max_width)

  # Create image with ggplot2
  img <- ggplot() +
    geom_text(aes(x = 0, y = 0, label = wrapped_joke), size = 6, family = "Courier",
              color = "green", hjust = 0.5, vjust = 0.5) +
    theme_void() +
    theme(plot.background = element_rect(fill = "black"))

  # Get the current working directory
  save_path <- file.path(getwd(), "programmer_joke.png")

  # Save the image in the current working directory
  ggsave(save_path, plot = img, width = 10, height = 6, dpi = 150, bg = "black")

  message("Joke image saved to: ", save_path)

  return(save_path)  # Return the file path
}

# Function to fetch and print a joke to the console
progr_joke_print <- function() {
  # Ensure httr and jsonlite are loaded
  library(httr)
  library(jsonlite)

  url <- "https://v2.jokeapi.dev/joke/Programming?type=single"

  response <- GET(url)

  # Check if API call was successful
  if (status_code(response) != 200) {
    stop("Failed to fetch joke from API")
  }

  joke_data <- fromJSON(content(response, "text", encoding = "UTF-8"))

  # Handle different API responses (some have "joke", some have "setup")
  joke <- ifelse("joke" %in% names(joke_data), joke_data$joke, joke_data$setup)

  # Print the joke to the console
  cat("Here's a programmer joke:\n")
  cat(joke, "\n")
}

