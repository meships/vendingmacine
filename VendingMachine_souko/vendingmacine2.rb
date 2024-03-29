class VendingMachine

  
    # ステップ０　お金の投入と払い戻しの例コード
    # ステップ１　扱えないお金の例コード

 


    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    MONEY = [10, 50, 100, 500, 1000].freeze
  
    # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
    def initialize
      # 最初の自動販売機に入っている金額は0円
      @slot_money = 0
      @sales = 0
    end
  
    def juice_stock(juices) #追記 12/14
        juices.each do |juice|
            puts juice.name
            puts juice.price
            puts juice.stock
        end
    end

    def buy(name) #追記 12/7
      if name == "cola"
        if @slot_money >= @juices[0][:price] && @juices[0][:stock] >= 1
          @slot_money -= @juices[0][:price]
          @juices[0][:stock] -= 1
          @sales += @juices[0][:price]
          puts "残金#{current_slot_money}"
        else
          puts "残金不足"
        end

      elsif name == "redbull"
        if @slot_money >= @juices[1][:price] && @juices[1][:stock] >= 1
          @slot_money -= @juices[1][:price]
          @juices[1][:stock] -= 1
          @sales += @juices[1][:price]
          puts "残金#{current_slot_money}"
        else
          puts "残金不足"
        end

      elsif name == "water"
        if @slot_money >= @juices[2][:price] && @juices[2][:stock] >= 1
          @slot_money -= @juices[2][:price]
          @juices[2][:stock] -= 1
          @sales += @juices[2][:price]
          puts "残金#{current_slot_money}"
        else
          puts "残金不足"
        end

      else
        puts "そんなのはねぇ！"
        puts "残金#{current_slot_money}"
      end
    end

    def sales #追記 12/9
      puts "売上金"
      @sales
    end

    def buy_list
      a = 0
      @juices.each do |juice|
        #puts juice[:name] + ":" + juice[:stock].to_s
        if @slot_money >= juice[:price] && juice[:stock] >= 1
          puts juice[:name] + ":" + juice[:stock].to_s
          a += 1
        end
      end
      puts "買えるものはありません" if a == 0
    end

    # 投入金額の総計を取得できる。
    def current_slot_money
      # 自動販売機に入っているお金を表示する
      @slot_money
    end
  
    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    # 投入は複数回できる。
    def slot_money(money)
      # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
      # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      return false unless MONEY.include?(money)
      # 自動販売機にお金を入れる
      @slot_money += money
    end
  
    # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
    def return_money
      # 返すお金の金額を表示する
      puts @slot_money
      # 自動販売機に入っているお金を0円に戻す
      @slot_money = 0
    end

end


class Juice
    attr_reader :name, :price, :stock
    def initialize(name, price, stock)
        @name = name
        @price = price
        @stock = stock
    end
end
