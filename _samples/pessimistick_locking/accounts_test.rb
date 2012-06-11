# CREATE TABLE `accounts` (
#   `id` int(11) NOT NULL AUTO_INCREMENT,
#   `number` varchar(255) DEFAULT NULL,
#   `balance` int(11) DEFAULT NULL,
#   PRIMARY KEY (`id`)
# ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
# 
# insert into accounts values(1, 'AC 01', 50);
# insert into accounts values(2, 'AC 02', 50);
# insert into accounts values(3, 'AC 03', 50);

require 'logger'
require 'sequel'

def transfer
  ac_01 = Account[:number => 'AC 01']
  ac_02 = Account[:number => 'AC 02']
  ac_03 = Account[:number => 'AC 03']

  source = [ac_01, ac_02, ac_03][rand(3)]
  destination = Account.filter(~{:id => source.id}).first

  transfer_amount = source.balance / 2

  source.update(:balance => source.balance - transfer_amount)
  destination.update(:balance => destination.balance + transfer_amount)
  puts "Thread Sum balance: #{Account.sum(:balance).to_i}"
end

def transfer_lock_model
  ac_01 = Account[:number => 'AC 01']
  ac_02 = Account[:number => 'AC 02']
  ac_03 = Account[:number => 'AC 03']

  source = [ac_01, ac_02, ac_03][rand(3)]
  destination = Account.filter(~{:id => source.id}).first

  source.lock!
  destination.lock!

  transfer_amount = source.balance / 2

  source.update(:balance => source.balance - transfer_amount)
  destination.update(:balance => destination.balance + transfer_amount)
  puts "Thread Sum balance: #{Account.sum(:balance).to_i}"
end

def transfer_for_update
  Account.db.transaction(:isolation => :serializable) do
    ac_01 = Account.for_update[:number => 'AC 01']
    ac_02 = Account.for_update[:number => 'AC 02']
    ac_03 = Account.for_update[:number => 'AC 03']

    source = [ac_01, ac_02, ac_03][rand(3)]
    destination = Account.for_update.filter(~{:id => source.id}).first

    transfer_amount = source.balance / 2

    source.update(:balance => source.balance - transfer_amount)
    destination.update(:balance => destination.balance + transfer_amount)
    puts "Thread Sum balance: #{Account.sum(:balance).to_i}"
  end
end

def transfer_for_update_ids
  Account.db.transaction(:isolation => :serializable) do
    ac_01 = Account[1]
    ac_02 = Account[2]
    ac_03 = Account[3]

    source = [ac_01, ac_02, ac_03][rand(3)]
    source = Account.for_update[source.id]
    destination = Account.for_update.filter(~{:id => source.id}).first

    transfer_amount = source.balance / 2

    source.update(:balance => source.balance - transfer_amount)
    destination.update(:balance => destination.balance + transfer_amount)
    #puts "Thread Sum balance: #{Account.sum(:balance).to_i}"
  end
end

def transfer_lock_model_transaction
  ac_01 = Account[:number => 'AC 01']
  ac_02 = Account[:number => 'AC 02']
  ac_03 = Account[:number => 'AC 03']

  source = [ac_01, ac_02, ac_03][rand(3)]
  destination = Account.filter(~{:id => source.id}).first

  Account.db.transaction do
    source.lock!
    destination.lock!

    transfer_amount = source.balance / 2

    source.update(:balance => source.balance - transfer_amount)
    destination.update(:balance => destination.balance + transfer_amount)
    puts "Thread Sum balance: #{Account.sum(:balance).to_i}"
  end
end

DB = Sequel.connect('jdbc:mysql://localhost/toplines?user=root&password=root', 
                    :autocommit => false,
                   :logger => Logger.new('db.log'))

class Account < Sequel::Model
end

# DB.create_table :accounts do 
#   primary_key :id
#   String :number
#   Integer :balance
# end

accounts = DB[:accounts]

# accounts.insert(:number => 'AC 01', :balance => 75)
# accounts.insert(:number => 'AC 02', :balance => 25)

#puts "Items count: #{items.count}"

puts "Sum balance: #{accounts.sum(:balance).to_i}"

threads = []
4.times do
  threads << Thread.new do
    #transfer
    #transfer_lock_model # inconsistent
    #transfer_for_update # 150 always, serializable
    #transfer_lock_model_transaction # 150 always, serializable
    transfer_for_update_ids # 150 at the end, != 150 at each thread end
  end
end

threads.each do |t|
  t.join
end
puts "FINAL Sum balance: #{accounts.sum(:balance).to_i}"

