# Charger les bibliothèques nécessaires
library(ggplot2)
library(tidyverse)

# Charger le fichier CSV
fichier_csv <- "references/modules_fr.csv"
donnees <- read_csv(fichier_csv) %>%
  rename(Module = ...1)

# Convertir les données en format long
donnees_longues <- donnees %>%
  pivot_longer(cols = starts_with("19") | starts_with("20"), names_to = "Année", 
               values_to = "Présent")

# Convertir 'Présent' en logique pour un filtrage et un tri plus faciles
donnees_longues <- donnees_longues %>%
  mutate(Présent = as.logical(Présent))

# Créer le graphique en barres "lollipop"
module_plot <- ggplot(donnees_longues %>% filter(Présent), 
                      aes(x = Année, y = factor(Module, levels = rev(donnees$Module)))) +
  geom_segment(aes(xend = Année, yend = Module), size = 1) +
  geom_point(size = 4, color = "black") +
  theme_minimal() +
  labs(title = NULL, x = NULL, y = NULL) +
  theme(axis.text.y = element_text(size = 8), 
        legend.position = "none",
        plot.title = element_blank(),
        plot.subtitle = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x.top = element_text(angle = 90, vjust = 0.5, hjust = 0)) +
  scale_x_discrete(position = "top")

ggsave(filename = "figure_2_fr.pdf", 
       plot = module_plot,
       path = "output",
       width = 1800, height = 1800, units = "px", dpi = 300)
ggsave(filename = "figure_2_fr.png", 
       plot = module_plot,
       path = "output",
       width = 1800, height = 1800, units = "px", dpi = 300)

module_plot
