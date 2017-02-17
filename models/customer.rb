require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    return customers.map {|customer| Customer.new(customer)}   
  end




end