require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}   
  end

  def save()
    sql = "INSERT INTO tickets (customer_id,film_id) VALUES (#{@customer_id},#{@film_id}) RETURNING id"
    ticket = SqlRunner.run(sql)[0]
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    self.get_many(sql)
  end

  def update()
    sql = "UPDATE tickets SET (customer_id,film_id) = (#{@customer_id}, #{@film_id}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = #{@id}"
    SqlRunner.run(sql)
  end


end