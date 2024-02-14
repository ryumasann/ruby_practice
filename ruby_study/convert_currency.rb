def convert_currency(amount, source_currency, target_currency, conversion_rates)
    # Round down
    puts (amount * conversion_rates[:usd] * conversion_rates[:jpy]).floor
    # Round up
    # puts (amount * conversion_rates[:usd] * conversion_rates[:jpy]).ceil
end

conversion_rates = {
  usd: 1.0,
  jpy: 110.0,
  eur: 0.8
}

convert_currency(100, :usd, :jpy, conversion_rates)
