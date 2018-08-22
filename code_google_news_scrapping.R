


# ----------------
# organizando:
library(dplyr)
library(rvest)
library(stringr)
google <- read_html("https://news.google.com/?hl=pt-BR&gl=BR&ceid=BR:pt-419")

veiculo_all <- google %>% html_nodes("div div div main c-wiz div div div article div div div") %>% html_text() %>%
  str_subset("[^more_vert]") %>%
  str_subset("[^share]") %>%
  str_subset("[^bookmark_border]") # 141

tempo_all <- google %>% html_nodes("div article div div time") %>% html_text()


nome_all <- google %>% html_nodes("article") %>% html_text("span") %>%
  str_split("(?<=[a-z0-9áéó!?])(?=[A-Z])")

nome_all <- sapply(nome_all, function(x) x[1])


df_news <- data_frame(veiculo_all, tempo_all, nome_all)

help("str_split")