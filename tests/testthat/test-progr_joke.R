library(testthat)

# Test for progr_joke_img()
test_that("progr_joke_img generates and saves meme image", {
  # Call the function
  result <- progr_joke_img()

  # Check if the result is a valid file path
  expect_true(file.exists(result))

  # Check if the saved file has the correct name
  expect_true(grepl("programmer_joke.png", result))

  # Clean up by removing the image after test
  file.remove(result)
})

# Test for progr_joke_print()
test_that("progr_joke_print prints joke to console", {
  # Capture console output
  expect_output(progr_joke_print(), "Here's a programmer joke:")
})
