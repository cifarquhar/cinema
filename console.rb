require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')


customer1 = Customer.new('name' => "Colin", 'funds' => 100)
customer2 = Customer.new('name' => "Vicky", 'funds' => 200)
customer3 = Customer.new('name' => "Ringo", 'funds' => 50)

customer1.save()
customer2.save()
customer3.save()







binding.pry
nil