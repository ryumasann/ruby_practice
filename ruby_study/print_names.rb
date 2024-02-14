def print_names(names)
  names.each.with_index(1){ |name, i| puts "#{i}. #{name}"}
end

print_names(['上田', '田仲', '堀田'])