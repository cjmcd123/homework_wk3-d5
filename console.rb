require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Screening.delete_all()
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

screening1 = Screening.new({'film_id' => film1.id, 'screeing_time' => '20:00', 'max_tickets' => 25})
screening2 = Screening.new({'film_id' => film2.id, 'screeing_time' => '16:00', 'max_tickets' => 20})
screening3 = Screening.new({'film_id' => film2.id, 'screeing_time' => '19:00', 'max_tickets' => 15})
screening4 = Screening.new({'film_id' => film3.id, 'screeing_time' => '13:00', 'max_tickets' => 30})
screening1.save()
screening2.save()
screening3.save()
screening4.save()

# ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
# ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
# ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening2.id})
# ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
# ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id, 'screening_id' => screening4.id})
# ticket6 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id, 'screening_id' => screening4.id})
# ticket1.save()
# ticket2.save()
# ticket3.save()
# ticket4.save()
# ticket5.save()
# ticket6.save()

Ticket.add_ticket(customer1.id, film2.id, screening3.id)
Ticket.add_ticket(customer2.id, film2.id, screening3.id)
Ticket.add_ticket(customer3.id, film2.id, screening2.id)
Ticket.add_ticket(customer1.id, film1.id, screening1.id)
Ticket.add_ticket(customer2.id, film3.id, screening4.id)
Ticket.add_ticket(customer3.id, film3.id, screening4.id)

film2.title = "Solo: A Star Wars Story"
film2.update()


binding.pry
nil
