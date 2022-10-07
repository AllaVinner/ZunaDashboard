


generate_beta_sells <- function(num_sells, start_date, end_date, alpha, beta) {
  betas <- rbeta(num_sells, alpha, beta)
  sells <- start_date + (end_date - start_date)*betas
  sells[order(sells)]
}










