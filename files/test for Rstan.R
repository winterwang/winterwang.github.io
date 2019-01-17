color_scheme_set("mix-blue-pink")

posterior2 <- rstan::extract(fit, inc_warmup = TRUE, permuted = FALSE)

p <- mcmc_trace(posterior2, n_warmup = 0,
                facet_args = list(nrow = 2, labeller = label_parsed))
p


p <- mcmc_acf_bar(posterior2)
p

p <- mcmc_hist(posterior2)
p

p <- mcmc_dens_overlay(posterior2, color_chains = T)
p


# use ggmcmc

ggmcmc(ggs(fit), file = "fit-ggmcmc.pdf")
