def print_capitals(capitals)
    capitals.each{ |key, value| puts "#{key}の首都は#{value}です"}
end

print_capitals({ '日本' => '東京', 'アメリカ' => 'ワシントンD.C.' })
