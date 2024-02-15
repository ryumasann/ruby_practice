class VendingMachine
    MAX_CUPS = 100
    def initialize(vender_name)
        @vender_name = vender_name
        @total_amount = 0
        @cup_inventory = 0
    end

    def press_button(vending_item)
        if @total_amount >= vending_item.price
            if vending_item.is_a?(CupCoffee) && @cup_inventory > 0
                puts "#{vending_item.name} cup coffee"
                @cup_inventory -= 1
                @total_amount -= vending_item.price
            elsif vending_item.is_a?(Drink)
                puts vending_item.name
                @total_amount -= vending_item.price
            end
        end
    end

    def add_cup(num)
        @cup_inventory += num
        puts @cup_inventory
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
        when 'cider'
            100
        when 'hot'
            100
        when 'cold'
            100
        else
            puts name
            raise
        end
    end
end

# 飲み物に関する責務のクラスを継承を利用して作成してください
class Drink < VendingItem
    attr_accessor :name, :price
    def initialize(name)
        super
        @price = 100
    end
end

# カップコーヒーに関する責務のクラスを継承を利用して作成してください
class CupCoffee < VendingItem
    attr_accessor :name, :price
    def initialize(name)
        super
        @price = 100
    end
end

# input
hot_cup_coffee = CupCoffee.new('hot');
cider = Drink.new('cider')
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cider)

puts vending_machine.press_button(hot_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(hot_cup_coffee)