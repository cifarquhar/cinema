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
    sql = "UPDATE customers SET (name,funds) = ('#{@name}', #{@funds}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end




end