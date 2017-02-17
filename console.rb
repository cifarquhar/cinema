require('pry')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')


Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => "Colin", 'funds' => 100})
customer2 = Customer.new({'name' => "Vicky", 'funds' => 200})
customer3 = Customer.new({'name' => "Ringo", 'funds' => 50})

customer1.save()
customer2.save()
customer3.save()


film1 = Film.new('title' => "T2", 'price' => 10)
film2 = Film.new('title' => "Blade Runner", 'price' => 15)
film3 = Film.new('title' => "Lego Batman", 'price' => 8)

film1.save()
film2.save()
film3.save()


ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id, 'show_time' => '21:00')
ticket2 = Ticket.new('customer_id' => customer2.id, 'film_id' => film3.id, 'show_time' => '19:45')
ticket3 = Ticket.new('customer_id' => customer3.id, 'film_id' => film2.id, 'show_time' => '18:00')
ticket4 = Ticket.new('customer_id' => customer1.id, 'film_id' => film2.id, 'show_time' => '18:00')
ticket5 = Ticket.new('customer_id' => customer3.id, 'film_id' => film1.id, 'show_time' => '21:00')
ticket6 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id, 'show_time' => '22:30')

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()


binding.pry
nil