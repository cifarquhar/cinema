require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price, :tickets_sold, :ticket_limit

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
    @ticket_limit = options['ticket_limit']
    @tickets_sold = Hash.new(0)
  end

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}   
  end

  def save()
    sql = "INSERT INTO films (title,price,ticket_limit) VALUES ('#{@title}',#{@price},#{@ticket_limit}) RETURNING id"
    film = SqlRunner.run(sql)[0]
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    self.get_many(sql)
  end

  def update()
    sql = "UPDATE films SET (title,price,ticket_limit) = ('#{@title}', #{@price}, #{@ticket_limit}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT c.* FROM customers c INNER JOIN tickets t ON t.customer_id = c.id WHERE t.film_id = #{@id}"
    films_customers = Customer.get_many(sql)
    number_of_customers = films_customers.count
    return number_of_customers
  end

  def mode(input_array)
    count_array = input_array.uniq.map {|e| [e, input_array.count(e)]}
    sorted_array = count_array.sort_by {|_,num| -num}
    trimmed_array = sorted_array.take_while {|_,num| num == sorted_array.first.last}
    modal_value = trimmed_array.map(&:first)
    return modal_value
  end

  def most_popular_time()
    sql = "SELECT t.* FROM tickets t INNER JOIN films f ON t.film_id = f.id WHERE t.film_id = #{@id}"
    films_tickets = Ticket.get_many(sql)
    films_tickets_times = films_tickets.map {|ticket| ticket.show_time}
    most_popular = mode(films_tickets_times)
    return most_popular
  end


end