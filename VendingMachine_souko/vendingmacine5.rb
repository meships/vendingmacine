class VendingMachine

    MONEY = [10, 50, 100, 500, 1000].freeze

    def initialize
      @total_money = 0
      @slot_money = 0
      #@stock = stock
      @cola_stock = []
      
    end

    def refill(juice)
      @cola_stock << juice
    end

    def current_slot_money
      @slot_money
    end

    def sales
      @total_money
    end

    def buy_list
      count = 0
      @stock.juices.each do |juice|
        if juice.price <= @slot_money  && juice.stock >= 1
          puts "#{juice.name}"
          count += 1
        end
      end
      puts "買える物はありません" if count == 0
    end

    def slot_money(money)
      return false unless MONEY.include?(money)
      @slot_money += money
    end

    def buy(juice)
      if @slot_money >= juice.price && @cola_stock.length >= 1
        @slot_money -=juice.price
        #juice.out
        @cola_stock.shift()
        @total_money += juice.price
        puts "#{juice.name}を購入しました"
        puts "在庫#{@cola_stock.length}"
      else
        puts "お金が足りないか在庫がありません"
      end
    end

    def return_money
      puts @slot_money
      @slot_money = 0
    end

end


class Juice

    attr_reader :name, :price, :stock

    def initialize(args)
        @name = args[:name]
        @price = args[:price]
       # @stock = args[:stock]
    end

    # def out
    #     @stock -= 1
    # end

end


# class Stock

#     attr_reader :juices

#     def initialize(juices)
#         @juices = juices
#     end

#     def stock_display
#         @juices.each do |juice|
#         puts "名前:#{juice.name}値段:#{juice.price}在庫:#{juice.stock}"
#         end
#     end

# end


# class Player

#     attr_reader :cola, :redbull, :water, :stock, :vm

#     def initialize
#         @cola = Juice.new(name: "cola", price: 120, stock: 5)
#         @redbull = Juice.new(name: "redbull", price: 200, stock: 5)
#         @water = Juice.new(name: "water", price: 100, stock: 5)
#         @stock =Stock.new([@cola,@redbull,@water])
#         @vm = VendingMachine.new(stock)
#     end

# end

  #juiceはストックをメンバに含めずstockクラスで在庫を持つ
  #inメソッドで補充、outメソッドで払い出す
  #newしたjuiceをstockに補充する