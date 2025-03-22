library(httr)
library(jsonlite)
library(ggplot2)
library(stringr)  # For text wrapping

# Function to generate and save meme-style image with dad joke
dad_joke_img <- function() {
  url <- "https://v2.jokeapi.dev/joke/Miscellaneous?type=single"

  response <- GET(url)

  # Check if API call was successful
  if (status_code(response) != 200) {
    stop("Failed to fetch joke from API")
  }

  joke_data <- fromJSON(content(response, "text", encoding = "UTF-8"))

  # Extract the joke text safely
  joke <- ifelse("joke" %in% names(joke_data), joke_data$joke, joke_data$setup)

  # Wrap long jokes into multiple lines (max 40 characters per line)
  wrapped_joke <- str_wrap(joke, width = 40)

  # Adjust font size dynamically (longer jokes = smaller text)
  joke_length <- nchar(joke)
  font_size <- ifelse(joke_length > 100, 5, 8)  # Reduce size for long jokes

  # Create image with ggplot2
  img <- ggplot() +
    geom_text(aes(x = 0, y = 0, label = wrapped_joke),
              size = font_size, family = "Comic Sans MS",
              color = "white", hjust = 0.5, vjust = 0.5, lineheight = 1.2) +
    theme_void() +
    theme(plot.background = element_rect(fill = "black"))

  # Get the current working directory
  save_path <- file.path(getwd(), "dad_joke.png")

  # Save the image in the current working directory
  ggsave(save_path, plot = img, width = 10, height = 6, dpi = 150, bg = "black")

  message("Joke image saved to: ", save_path)

  return(save_path)  # Return the file path
}

# Function to fetch and print a dad joke to the console
dad_joke_print <- function() {
  url <- "https://v2.jokeapi.dev/joke/Miscellaneous?type=single"

  response <- GET(url)

  # Check if API call was successful
  if (status_code(response) != 200) {
    stop("Failed to fetch joke from API")
  }

  joke_data <- fromJSON(content(response, "text", encoding = "UTF-8"))

  # Extract the joke text safely
  joke <- ifelse("joke" %in% names(joke_data), joke_data$joke, joke_data$setup)

  # Print the joke to the console
  cat("Here's a dad joke:\n")
  cat(joke, "\n")
}
