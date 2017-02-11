## In this file, we plot the results from the simulation study.

library(ggplot2)
library(tidyr)
suppressMessages(library(dplyr))
library(xtable)

## Read in simulations results -----------------------------------------------
lstein   <- read.csv("./output/sims_out/losses_stein.csv")
lcandes2 <- read.csv("./output/sims_out/losses_candes2.csv")
lem      <- read.csv("./output/sims_out/losses_em.csv")
lcandes  <- read.csv("./output/sims_out/losses_candes.csv")
ltrunc   <- read.csv("./output/sims_out/losses_trunc.csv")
lsoft    <- read.csv("./output/sims_out/losses_soft.csv")

lstein$theta   <- "A" ## "uncorrelated"
lcandes2$theta <- "B" ## "dispersed_one_mode"
lem$theta      <- "C" ## "ar1_one_mode"
lcandes$theta  <- "D" ## "low_rank_one_mode"
lsoft$theta    <- "E" ## "evenly_dispersed_svs"
ltrunc$theta   <- "F" ## "low_multilinear_rank"

ldat <- select(lstein, 1:6, 15) %>%
  bind_rows(select(lcandes2, 1:6, 15)) %>%
  bind_rows(select(lem, 1:6, 15)) %>%
  bind_rows(select(lcandes, 1:6, 15)) %>%
  bind_rows(select(ltrunc, 1:6, 15)) %>%
  bind_rows(select(lsoft, 1:6, 15)) %>%
  gather(key = "Method", value = "Loss", contains("loss_"))
ldat$Method <- stringr::str_replace(string = ldat$Method, pattern = "loss_", replacement = "")
ldat$Method[ldat$Method == "x"] <- "X"
ldat$Method[ldat$Method == "soft"] <- "ST"
ldat$Method[ldat$Method == "trunc"] <- "Tr"
ldat$Method[ldat$Method == "em"] <- "EM"
ldat$Method[ldat$Method == "candes"] <- "MS"
ldat$Method[ldat$Method == "stein"] <- "JS"
ldat$Method <- factor(ldat$Method, levels = c("ST", "Tr", "MS", "EM", "JS", "X"))

smalldat <- ldat %>% group_by(Method, theta) %>% summarise(Mean = mean(Loss)) %>% ungroup() %>%
  group_by(theta) %>% summarise(`Minimum Risk` = min(Mean))

pdf(file = "./output/figures/different_scenario_sims_losses_combined2.pdf",
    width = 6.5, height = 7, family = "Times")
ggplot(data = ldat, mapping = aes(x = Method, y = Loss)) +
  facet_wrap(~theta) +
  geom_boxplot() +
  theme_bw() +
  theme(strip.background = element_rect(fill="white")) +
  geom_hline(yintercept = 1000, lty = 2) + ## 1000 for the product of the dimension, theoretical risk of X
  geom_hline(data = smalldat, mapping = aes(yintercept = `Minimum Risk`), lty = 3)
dev.off()


#############################
## Looking at how well the rank is estimated. --------------------------------
#############################

ldat <- select(lstein, contains("rank"), 15) %>%
  bind_rows(select(lcandes2, contains("rank"), 15)) %>%
  bind_rows(select(lem, contains("rank"), 15)) %>%
  bind_rows(select(lcandes, contains("rank"), 15)) %>%
  bind_rows(select(ltrunc, contains("rank"), 15)) %>%
  bind_rows(select(lsoft, contains("rank"), 15))

## the following is the proportion of times that the true
## multilinear rank was selected correctly in scenario F
prop_correct <- mean(apply(filter(ldat, theta == "F") %>% select(contains("rank")) == 5, 1, all))
cat(paste0("Proportion times correct in Scenario F: ", prop_correct),
    file = "./output/figures/prop_correct_F.txt")

## Now look at scenario D ----------------------------------------------------
ddat <- filter(ldat, theta == "D") %>% select(contains("rank"))
minrank <- min(ddat)
maxrank <- max(ddat)
propdat <- rbind(table(factor(ddat$rank1, levels = minrank:maxrank)) / nrow(ddat),
                 table(factor(ddat$rank2, levels = minrank:maxrank)) / nrow(ddat),
                 table(factor(ddat$rank3, levels = minrank:maxrank)) / nrow(ddat))
propdat <- format(round(propdat, digits = 2))
propdat <- apply(propdat, 1, stringr::str_replace, pattern = "0.00", replacement = "0")
propdat <- apply(propdat, 1, stringr::str_replace, pattern = "0\\.", replacement = "\\.")
dimnames(propdat) = list(c("Mode 1", "Mode 2", "Mode 3"), "Estimated Rank" = minrank:maxrank)
xout <- xtable(propdat, label = "tab:rank.est",
               caption = "Proportion of times each rank is estimated based on SURE for each mode over 500 repetitions when the true multilinear rank is (5, 10, 10).")
trash <- utils::capture.output(cat(print(xout), file = "./output/figures/table1.txt"))

