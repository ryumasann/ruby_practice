def square(numbers)
    new_members = []
    numbers.each{ |n| new_members << n ** 2}
    new_members
end

squared_numbers = square([5, 7, 10])
print squared_numbers