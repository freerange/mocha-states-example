require 'bundler/setup'
require 'minitest/unit'
require 'minitest/autorun'
require 'mocha/mini_test'

require_relative 'bank'

class BankTest < MiniTest::Unit::TestCase
  def test_moving_funds_using_transactions
    database_manager = mock('database-manager')
    account_one = mock('account-one')
    account_two = mock('account-two')

    transaction = states('transaction').starts_as('inactive')

    database_manager.expects(:begin_transaction).then(transaction.is('active'))
    account_one.expects(:withdraw).with(1000).when(transaction.is('active'))
    account_two.expects(:deposit).with(1000).when(transaction.is('active'))
    database_manager.expects(:close_transaction).then(transaction.is('inactive'))

    bank = Bank.new(database_manager)
    bank.transfer_funds(account_one, account_two, 1000)
  end
end
