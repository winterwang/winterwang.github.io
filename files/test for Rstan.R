color_scheme_set("mix-blue-pink")

posterior2 <- rstan::extract(fit, inc_warmup = TRUE, permuted = FALSE)

p <- mcmc_trace(posterior2, n_warmup = 0,
                facet_args = list(nrow = 2, labeller = label_parsed))
p
