def convert_currency(amount, source_currency, target_currency, conversion_rates)
    puts (amount * conversion_rates[:usd] * conversion_rates[:jpy]).floor
end

conversion_rates = {
  usd: 1.0,
  jpy: 110.0,
  eur: 0.8
}

convert_currency(100, :usd, :jpy, conversion_rates)
