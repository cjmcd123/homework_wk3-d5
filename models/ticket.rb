require_relative("../db/sql_runner")
require('pry')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (customer_id, film_id, screening_id)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    visit = SqlRunner.run( sql,values ).first
    @id = visit['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET
    (customer_id, film_id, screening_id) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    result = SqlRunner.run(sql, values)
    return Film.new(result[0])
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values)
    return Customer.new(result[0])
  end

  def screening()
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [@screening_id]
    result = SqlRunner.run(sql, values)
    return Screening.new(result[0])
  end

  def self.add_ticket(customer_id, film_id, screening_id)
    ticket = Ticket.new({'customer_id' => customer_id, 'film_id' => film_id, 'screening_id' => screening_id})
    screening = ticket.screening()
    if screening.tickets_sold.to_i <= screening.max_tickets.to_i
      ticket.save()
      person = ticket.customer()
      fund = person.funds.to_i
      movie = ticket.film()
      film_price = movie.price.to_i
      remaining_fund = fund - film_price
      person.funds = remaining_fund
      person.update()
    else
      return "Screening full"
    end
  end

  def delete()
    sql = "DELETE FROM tickets where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
