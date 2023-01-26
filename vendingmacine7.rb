#その1 コメントなしver
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total_money = 0
    @slot_money = 0
    @juice = {}
    @juices = []
    @lighting_list =[]
    juice_setup
  end
  def current_slot_money
    @slot_money
  end
  def sales
    @total_money
  end
  def stocks
    @juices
  end
  def buy_list
    index = 0
    @lighting_list.clear
    @juices.each do |juice|
      if juice[:price] <= @slot_money  && juice[:stock] >= 1
        puts "#{index}:#{juice[:name]}"
        index += 1
        @lighting_list << juice
      end
    end
    if @lighting_list.empty?
      puts "買える物はありません"
    end
  end
  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
  end
  def buy
    while true
      buy_list
      return if @lighting_list.empty?
      puts "購入するジュースを番号で選択して下さい。購入をやめる場合は999を入力してください。"
      input = gets.chomp
      if input =~ /^[0-9]+$/ && (0..@lighting_list.length-1).cover?(input.to_i)
        break
      elsif input.to_i == 999
        return puts "購入を中止します"
      else
        puts "その番号は存在しません"
      end
    end
    juice = @lighting_list[input.to_i]
    @slot_money -=juice[:price]
    juice[:stock] -= 1
    @total_money += juice[:price]
    puts "#{juice[:name]}を購入しました"
    puts "在庫#{juice[:stock]}"
  end
  def return_money
    puts @slot_money
    @slot_money = 0
  end
  private
  def juice_setup
    refill(Juice.cola,5)
    refill(Juice.water,5)
    refill(Juice.red_bull,5)
  end
  def refill(juice,number)
    @juice = {
      name: juice.name,
      price: juice.price,
      stock: number
    }
    @juices << @juice
  end
end
class Juice
  attr_reader :name, :price
  def initialize(args)
    @name = args[:name]
    @price = args[:price]
  end
  def self.cola
    self.new(name: "cola", price: 120)
  end
  def self.water
    self.new(name: "water", price: 100)
  end
  def self.red_bull
    self.new(name: "red_bull", price: 200)
  end
end