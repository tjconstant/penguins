library(tidymodels)
library(readr)

df_analysis <-
  read_csv("https://raw.githubusercontent.com/tjconstant/penguins/main/penguins_analysis.csv") %>%
  mutate(species = as.factor(species))
df_assesment <-
  read_csv("https://raw.githubusercontent.com/tjconstant/penguins/main/penguins_assessment.csv") %>%
  mutate(species = as.factor(species))

Classifier <- decision_tree(mode = "classification")

model <- fit(Classifier, formula = species ~ ., data = df_analysis)

df_pred <- predict(model, new_data = df_assesment)

df_pred_all <- cbind(df_assesment, df_pred)

df_pred_all %>%
  conf_mat(truth = species, estimate = .pred_class)

df_pred_all %>%
  accuracy(truth = species, estimate = .pred_class)
