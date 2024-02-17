# frozen_string_literal: true

class VendingMachine
  MAX_CUPS = 100
  private_constant :MAX_CUPS
  def initialize(vender_name)
    @vender_name = vender_name
    @total_amount = 0
    @cup_inventory = 0
  end

  def press_button(vending_item)
    return unless @total_amount >= vending_item.price

    if vending_item.is_a?(CupCoffee) && @cup_inventory.positive?
      @cup_inventory -= 1
      @total_amount -= vending_item.price
      print "#{vending_item.name} cup coffee"
    elsif vending_item.is_a?(Drink)
      @total_amount -= vending_item.price
      print vending_item.name
    elsif vending_item.is_a?(Snack)
      @total_amount -= vending_item.price
      print vending_item.name
    end
  end

  def add_cup(num)
    @cup_inventory += num
  end

  def deposit_coin(total_amount)
    return unless total_amount == 100

    @total_amount += 100
  end

  private

  def press_manufacturer_name
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
             when 'cider', 'hot', 'cold'
               100
             else
               puts name
               raise
             end
  end
end

# 飲み物に関する責務のクラスを継承を利用して作成してください
class Drink < VendingItem
end

# カップコーヒーに関する責務のクラスを継承を利用して作成してください
class CupCoffee < VendingItem
end

# スナック菓子に関する責務のクラスを継承を利用して作成してください
class Snack < VendingItem
  PRICE = 150
  private_constant :PRICE
  NAME = 'potato chips'
  private_constant :NAME
  attr_reader :NAME, :PRICE

  def initialize
    @name = NAME
    @price = PRICE
  end
end

# input
hot_cup_coffee = CupCoffee.new('hot')
cider = Drink.new('cider')
snack = Snack.new
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cider)

puts vending_machine.press_button(hot_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(hot_cup_coffee)

puts vending_machine.press_button(snack)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(snack)
