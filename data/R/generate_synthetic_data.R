# ------------------------------------------------------------------
# Generate a SYNTHETIC registration dataset with the same structure as
# the proprietary data, so the modelling code can be run end-to-end.
#
# The coefficients below are illustrative, NOT estimated from real data.
# Do not interpret any result from this file as a finding.
# Run from the project root:  source("R/generate_synthetic_data.R")
# ------------------------------------------------------------------
set.seed(2026)
n <- 9179

jobs <- c("Technical Roles", "Consultant / Advisor", "Executive / C-level",
          "Marketing & Communications", "Product Management",
          "Purchasing / Procurement", "Sales & Business Development")

df <- data.frame(
  COUNTRY     = rbinom(n, 1, 0.60),
  JOB         = factor(sample(jobs, n, replace = TRUE,
                              prob = c(.25, .10, .10, .15, .10, .10, .20)),
                       levels = jobs),
  LEADTIME    = pmin(round(rexp(n, rate = 1 / 20)) + 1, 120),
  TIME_ATTEND = rbinom(n, 1, 0.20),
  COMPANYSIZE = rbinom(n, 1, 0.30)
)

# Illustrative effects (log-odds). Reference job level = 0.
job_eff <- c(0, -0.30, -0.20, -0.10, -0.25, -0.15, -0.05)
names(job_eff) <- jobs

eta <- -1.2 +
  0.17   * df$COUNTRY +
  job_eff[as.character(df$JOB)] +
  0.0276 * df$LEADTIME -
  0.80   * df$TIME_ATTEND -
  0.30   * df$COMPANYSIZE

df$STATUS <- rbinom(n, 1, plogis(eta))   # 1 = no-show, 0 = attended
df <- df[, c("STATUS", "COUNTRY", "JOB", "LEADTIME", "TIME_ATTEND", "COMPANYSIZE")]

dir.create("data", showWarnings = FALSE)
write.csv(df, "data/synthetic_registrations.csv", row.names = FALSE)

cat("Rows:", nrow(df), "| no-show rate:", round(mean(df$STATUS), 3), "\n")

# Quick check that the modelling pipeline runs on the synthetic data
df$JOB <- relevel(df$JOB, ref = "Technical Roles")
fit <- glm(STATUS ~ COUNTRY + JOB + LEADTIME + TIME_ATTEND + COMPANYSIZE,
           data = df, family = binomial(link = "logit"))
print(round(exp(coef(fit)), 3))   # odds ratios (synthetic, not real findings)
