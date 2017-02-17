require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    return films.map {|film| Film.new(film)}   
  end

  def save()
    sql = "INSERT INTO films (title,price) VALUES ('#{@title}',#{@price}) RETURNING id"
    film = SqlRunner.run(sql)[0]
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    self.get_many(sql)
  end

  def update()
    sql = "UPDATE films SET (title,price) = ('#{@title}', #{@price}) WHERE id = #{@id};"
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

  def count_customers()
    sql = "SELECT c.* FROM customers c INNER JOIN tickets t ON t.customer_id = c.id WHERE t.film_id = #{@id}"
    films_customers = Film.get_many(sql)
    number_of_customers = films_customers.count
  end



end