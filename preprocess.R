library(palmerpenguins)
library(tidymodels)
library(readr)

x <- initial_split(penguins)

rcp <- 
  recipe(species ~ ., x |> analysis()) |> 
  step_impute_mean(all_numeric_predictors()) |> 
  step_impute_mode(all_nominal_predictors()) 

df_analysis <- rcp |>  prep() |> bake(x |>  analysis())
df_assesment <- rcp |>  prep() |> bake(x |>  assessment())

write_csv(df_analysis, "penguins_analysis.csv")
write_csv(df_assesment, "penguins_assessment.csv")
