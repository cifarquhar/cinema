require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}   
  end

  def save()
    sql = "INSERT INTO customers (name,funds) VALUES ('#{@name}',#{@funds}) RETURNING id"
    customer = SqlRunner.run(sql)[0]
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    self.get_many(sql)
  end

  def update()
    sql = "UPDATE customers SET (name,funds) = ('#{@name}', #{@funds}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def deduct_funds(ticket_price)
    sql = "UPDATE customers SET (funds) = (#{@funds - ticket_price}) WHERE id = #{@id}"
    SqlRunner.run(sql)
    @funds -= ticket_price
  end

  def buy_tickets(film)
    new_ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id})
    deduct_funds(film.price)
    new_ticket.save()
  end

  def count_tickets()
    sql = "SELECT tickets.* FROM tickets INNER JOIN customers on tickets.customer_id = customers.id WHERE tickets.customer_id = #{@id}"
    tickets = Ticket.get_many(sql)
    number_of_tickets = tickets.count
  end




end