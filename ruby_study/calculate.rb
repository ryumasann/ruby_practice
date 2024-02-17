OPERATOR_LIST = ["+", "-", "*", "/"]
def calculate(num1, num2, operator)
    if (operator == "/") && (num2 == 0)
        raise ZeroDivisionError, "ゼロによる割り算は許可されていません"
    elsif !OPERATOR_LIST.include?(operator)
        raise "演算子には  +、-、*、/ のいずれかを使用してください"
    elsif !((num1 - num1.to_i == 0) && (num2 - num2.to_i == 0))
        raise "num1、 num2 には整数を入力してください"
    end
    result = num1.send(operator, num2).to_i
end

puts "1番目の整数を入力してください:"
num1 = gets.chomp.to_f

puts "2番目の整数を入力してください:"
num2 = gets.chomp.to_f

puts "演算子(+, -, *, /)を入力してください:"
operator = gets.chomp

begin
    result = calculate(num1, num2, operator)
    puts result
rescue ZeroDivisionError => e
    puts e.full_message
rescue StandardError => e
    puts e.full_message
end

# calculate(1, 0, '/')
# calculate(1.5, 2, '+')
# calculate(1.5, 2, '**')
# calculate(5, 2, '*')
