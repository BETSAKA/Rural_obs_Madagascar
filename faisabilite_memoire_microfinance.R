# Charge packages
library("tidyverse")
library("haven")


# Module ?? ---------------------------------------------------------------

# Charge données
res_p_2012 <- read_stata("data/dta_format/2012/res_p.dta")



# Module microfinance -----------------------------------------------------


# Charge données
res_mf_2012 <- read_stata("data/dta_format/2012/res_mf.dta")

# Etes vous membre/client d'une IMF
res_mf_2012 %>%
  group_by(mf2) %>%
  summarise(membre = n())

# Laquelle (option 1)
res_mf_2012 %>%
  group_by(mf22a1) %>%
  summarise(membre = n())

# Laquelle (option 2)
res_mf_2012 %>%
  group_by(mf22a2) %>%
  summarise(membre = n())

292/3068
