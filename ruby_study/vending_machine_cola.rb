class VendingMachine
    def initialize(vender_name)
        @vender_name = vender_name
        @amount = 0
    end

    def press_button(vending_item)
        if @amount >= 150
            case vending_item.name
            when 'cola'
                puts "cola"
                @amount -= 150
            when 'cider'
                puts "cider"
                @amount -= 100
            # else
            #     puts "???"
            end
        elsif
            case vending_item.name
            when 'cider'
                puts "cider"
                @amount -= 100
            # else
            #     puts "???"
            end
        end
    end

    def deposit_coin(amount)
        if amount == 100
            @amount += 100
            # puts @amount
        end
    end

    private
    def press_manufacturer_name()
        puts @vender_name
    end
end

class VendingItem
    attr_reader :name
    def initialize(name)
        @name = name
    end
end

cola = VendingItem.new('cola')
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
