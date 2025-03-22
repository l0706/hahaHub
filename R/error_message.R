library(ggplot2)

error_message <- function() {
  # List of funny programming error messages
  error_messages <- c(
    "SyntaxError: Unexpected brilliance detected.",
    "Warning: Your code is so bad, even Notepad++ refuses to open it.",
    "Error 404: Developer not found.",
    "Segmentation fault (core dumped)... Just like your motivation.",
    "Stack Overflow: Not the website, just your function calls.",
    "NullPointerException: Your hopes and dreams were null.",
    "System Error: Brain.exe has stopped working.",
    "Access Denied: Too many failed deploy attempts.",
    "Your commit message was rejected: 'Fixed stuff'.",
    "Blue Screen of Death incoming… Good luck!"
  )

  # Randomly select an error message
  error_text <- paste("Error:", sample(error_messages, 1))

  # Generate meme-style image with the error message
  img <- ggplot() +
    geom_text(aes(x = 0, y = 0, label = error_text), size = 6, family = "Courier",
              color = "red", hjust = 0.5, vjust = 0.5) +
    theme_void() +
    theme(plot.background = element_rect(fill = "black"))

  # Save the image in the current working directory
  save_path <- file.path(getwd(), "funny_error_message.png")
  ggsave(save_path, plot = img, width = 10, height = 6, dpi = 150, bg = "black")

  message("Error message image saved to: ", save_path)

  return(save_path)  # Return the file path
}

