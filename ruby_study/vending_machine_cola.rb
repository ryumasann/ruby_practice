class VendingMachine
    def initialize(vender_name)
        @vender_name = vender_name
        @total_amount = 0
    end

    def press_button(vending_item)
            if @total_amount >= vending_item.price
            puts vending_item.name
            @total_amount -= vending_item.price
        end
    end

    def deposit_coin(total_amount)
        if total_amount == 100
            @total_amount += 100
            # puts @total_amount
        end
    end

    private
    def press_manufacturer_name()
        puts @vender_name
    end
end

class VendingItem
    attr_reader :name, :price
    def initialize(name)
        @name = name
        @price = case name
        when 'cola'
            150
        when 'cider'
            100
        else
            puts name
            raise
        end
    end
end

cola = VendingItem.new('cola')
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
