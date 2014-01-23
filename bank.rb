class Bank
   def initialize(database_manager)
     @database_manager = database_manager
   end

   def transfer_funds(account_one, account_two, amount)
     @database_manager.begin_transaction
     account_one.withdraw(amount)
     account_two.deposit(amount)
     @database_manager.close_transaction
   end
end
