def sheep(n)
    x = 0
    (1..n).each{puts "羊が#{x += 1}匹"}
    # (1..n).each{puts "羊が#{x = x.next}匹"}
    # nextは遅いらしい
    # https://qiita.com/luccafort/items/11e3569095e5b5b67f8e
end
sheep(3)
sheep(1)
