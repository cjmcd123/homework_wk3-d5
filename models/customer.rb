require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
      (name, funds)
    VALUES
      ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    user = SqlRunner.run(sql, values).first
    @id = user['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET
      (name, funds) =
      ($1, $2)
      WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
      sql = "SELECT films.* FROM films
        INNER JOIN tickets
        ON tickets.film_id = films.id
        WHERE customer_id = $1;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map{|result| Film.new(result)}
  end

  def delete()
    sql = "DELETE FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    result = tickets.map{|ticket|}
    return result.length
  end


  def self.add_customer(name, funds)
    customer = Customer.new({'name' => name, 'funds' => funds})
    customer.save()
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

end
