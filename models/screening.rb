require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screeing_time, :max_tickets

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @screeing_time = options['screeing_time']
    @max_tickets = options['max_tickets']
  end

  def save()
    sql = "INSERT INTO screenings
      (film_id, screeing_time, max_tickets)
    VALUES
      ($1, $2, $3)
    RETURNING id"
    values = [@film_id, @screeing_time, @max_tickets]
    user = SqlRunner.run(sql, values).first
    @id = user['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET
      (film_id, screeing_time, max_tickets) =
      ($1, $2, $3)
      WHERE id = $4"
    values = [@film_id, @screeing_time, @max_tickets, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.add_screening(film_id, screeing_time, max_tickets)
    screening = Screening.new({'film_id' => film_id, 'screeing_time' => screeing_time, 'max_tickets' => max_tickets})
    screening.save()
  end

  def tickets_sold()
    sql = "SELECT tickets.* FROM tickets WHERE tickets.screening_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    result = tickets.map{|ticket| Ticket.new(ticket)}
    return result.length
  end

  def self.film(id_film)
    sql = "SELECT * FROM screenings where film_id = $1"
    values = [id_film]
    film = SqlRunner.run(sql, values)
    result = film.map{|film| Screening.new(film)}
    return result
  end

  def self.best_screening(id_film)
    screening = 0
    films = self.film(id_film)
    for film in films
      result = film.tickets_sold()
      if result > screening
        screening = result
        answer = film
      end
    end
    return answer
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

end
