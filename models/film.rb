require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
      (title, price)
    VALUES
      ($1, $2)
    RETURNING id"
    values = [@title, @price]
    location = SqlRunner.run(sql, values).first
    @id = location['id'].to_i
  end

  def update()
    sql = "UPDATE films SET
      (title, price) =
      ($1, $2)
      WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|result| Customer.new(result)}
  end

  def self.add_film(title, price)
    film = Film.new({'title' => title, 'price' => price})
    film.save()
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

end
