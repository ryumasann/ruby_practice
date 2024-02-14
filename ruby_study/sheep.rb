def sheep(n)
    x = 0
    (1..n).each{puts "羊が#{x += 1}匹"}
    # (1..n).each{puts "羊が#{x = x.next}匹"}
end
sheep(3)
sheep(1)
