class Account
    attr_reader :name, :balance
    def initialize(name, balance=100)
        @name = name
        @balance = balance
    end
    def display_balance(pin_number)
        puts pin_number == pin ? "Balance: #{@balance}." : pin_error
    end
    def withdraw(pin_number,amount)
        if pin_number != pin
            puts pin_error
        elsif pin_number == pin && amount >= @balance
            puts insufficient_funds_error
        elsif pin_number == pin && amount <= @balance
            @balance -= amount
            puts "Withdrew $#{amount}. New balance: $#{balance}."
        end
    end
    def deposit(pin_number,amount)
        if pin_number == pin
            @balance += amount
            puts "Deposited $#{amount}. New balance: $#{balance}."
        else
            puts pin_error
        end
    end
    private
    def pin
        @pin = 1234
    end
    def pin_error
        "Access denied: incorrect PIN."
    end
    def insufficient_funds_error
        puts "You have insufficient funds to complete this transaction"
    end
end

checking_account = Account.new("Jim",3000)