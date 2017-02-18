require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :customer_id, :film_id, :show_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @show_time = options['show_time']
  end

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map {|ticket| Ticket.new(ticket)}   
  end

  def save()
    ticket_sql = "INSERT INTO tickets (customer_id,film_id,show_time) VALUES (#{@customer_id},#{@film_id},'#{@show_time}') RETURNING id"
    ticket = SqlRunner.run(ticket_sql)[0]
    @id = ticket['id'].to_i
    counter_sql = "SELECT films.* FROM films INNER JOIN tickets on tickets.film_id = films.id WHERE films.id = #{@film_id}" 
    films_to_update = SqlRunner.run(counter_sql)
    film_to_update = films_to_update.find {|film| film['id'] = @film_id}
    # puts film_to_update
    # tickets_to_update = film_to_update['tickets_sold']
    # if tickets_to_update["#{@show_time}"] == ticket['show_time']
    #     tickets_to_update["#{@show_time}"] += 1
    # end
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