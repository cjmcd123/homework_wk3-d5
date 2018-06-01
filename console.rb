require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Bob', 'funds' => 100})
customer2 = Customer.new({'name' => 'Charlie', 'funds' => 50})
customer3 = Customer.new({'name' => 'Jenny', 'funds' => 75})
customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({'title' => 'Avengers: Infinty War', 'price' => 5})
film2 = Film.new({'title' => 'Solo: A Star Story', 'price' => 7})
film3 = Film.new({'title' => '2001: A Space Odysey', 'price' => 4})
film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket6 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()

film2.title = "Solo: A Star Wars Story"
film2.update()



binding.pry
nil
