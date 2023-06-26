class Car
  def initialize(color, weight, price, speed = 200)
    @color = color
    @weight = weight
    @price = price
    @speed = speed
    Car.car_count
  end

  attr_accessor :color, :weight

  @@cars_count = 0

  def drive
    puts "start driving"
  end

  def stop
    puts "stopped"
  end

  def self.car_count
    @@cars_count += 1
  end

  def self.show_count
    puts @@cars_count
  end

  def price
    @price
  end

  # def color
  #   @color
  # end

  def price=(price)
    @price = price
  end

end

car_1 = Car.new
puts car_1.color = "black"
puts car_1.color
# car_1 = Car.new("black", 100, 150000, 150)
# car_1 = Car.new("black", 100, 150000, 150)
# puts car_1.price
# puts car_1.price = 300000
# puts car_1.price
# puts Car.show_count