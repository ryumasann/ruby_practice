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
    attr_accessor :cup_amount
    def initialize(name, cup_amount)
        super(name)
        @cup_amount = cup_amount
    end
endc

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