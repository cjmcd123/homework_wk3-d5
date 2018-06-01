require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
      (customer_id, film_id)
    VALUES
      ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    visit = SqlRunner.run( sql,values ).first
    @id = visit['id'].to_i
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

  def customer_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Customer.new(result[0])
  end

  def update()
    sql = "UPDATE movies SET
      (customer_id, film_id) =
      ($1, $2)
      WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.add_ticket(customer_id, film_id)
    customer =

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
