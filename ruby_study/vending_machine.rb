class VendingMachine
    def initialize(company_name)
        @company_name = company_name
    end

    def press_button()
        puts "cider"
    end

    def press_manufacturer_name()
        puts @company_name
    end
  end

vending_machine = VendingMachine.new('サントリー')
puts vending_machine.press_button

vending_machine.deposit_coin(150)
puts vending_machine.press_button
vending_machine.deposit_coin(100)
puts vending_machine.press_button

puts vending_machine.press_manufacturer_name
