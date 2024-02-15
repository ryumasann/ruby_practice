class VendingMachine
    def initialize(vender_name)
        @vender_name = vender_name
        @amount = 0
    end

    def press_button()
        if @amount >= 100
            puts "cider"
            @amount -= 100
        end
    end

    # attr_writer :deposit_coin
    def deposit_coin(amount)

        if amount == 100
            @amount += 100
        end
    end

    private
    def press_manufacturer_name()
        puts @vender_name
    end
end

vending_machine = VendingMachine.new('サントリー')
puts vending_machine.press_button

vending_machine.deposit_coin(150)
puts vending_machine.press_button
vending_machine.deposit_coin(100)
puts vending_machine.press_button

puts vending_machine.press_manufacturer_name
