library(testthat)

# Test for error_message()
test_that("error_message generates and saves meme image", {
  # Call the function
  result <- error_message()

  # Check if the result is a valid file path
  expect_true(file.exists(result))

  # Check if the saved file has the correct name
  expect_true(grepl("funny_error_message.png", result))

  # Clean up by removing the image after test
  file.remove(result)
})
