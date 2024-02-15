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

# 飲み物に関する責務のクラスを継承を利用して作成してください
class Drink < VendingItem
    attr_reader :status
    def initialize(name, status)
        super(name)
        @status = status
    end
end

# カップコーヒーに関する責務のクラスを継承を利用して作成してください
class CupCoffee < VendingItem
    attr_accessor :cup_total_amount
    def initialize(name, cup_total_amount)
        super(name)
        @cup_total_amount = cup_total_amount
    end
end

# input
hot_cup_coffee = #{カップコーヒーのクラス}.new('hot');
cider = #{飲み物のクラス}.new('cider')
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cider)

puts vending_machine.press_button(hot_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(hot_cup_coffee)