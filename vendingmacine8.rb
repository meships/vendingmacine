#その2コメント増量ver
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total_money = 0
    @slot_money = 0
    #ハッシュで在庫数を持つ為にハッシュを用意、ジュースの属性を表す
    @juice = {}
    #ハッシュを配列で管理する為に用意,在庫を表す
    @juices = []
    #点灯していて購入可能なリスト
    @lighting_list =[]
    #初期状態各5本をセットアップ
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
    #indexは表示した際の番号を表示。選択させる為に使用
    index = 0
    #@lighting_listを空にして初期化する
    #購入出来るものを@lighting_listにpushする
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
      #buy_listにより@lighting_list（購入可能なリスト）を作成する
      buy_list
      return if @lighting_list.empty?
      puts "購入するジュースを番号で選択して下さい。購入をやめる場合は999を入力してください。"
      input = gets.chomp
      #数字の羅列かつインデックスが範囲内であればwhileを抜ける
      #正規表現にマッチしなかった場合はnilが返る。
      #先頭が0~9が1つ以上かつ終わりも数字
      if input =~ /^[0-9]+$/ && (0..@lighting_list.length-1).cover?(input.to_i)
        break
      elsif input.to_i == 999
        return puts "購入を中止します"
      else
        puts "その番号は存在しません"
      end
    end
    #juiceは入力されたinputを@lighting_listとして代入する
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
  #外からアクセスされたくないメソッドの為privateをつける
  private
  #クラスメソッドとしてrefillメソッドでセットする
  #ここでインスタン化されたものと在庫を入力する事で
  #Juiceクラスの属性が追加されても問題ない
  #この初期化の作業により以後全てハッシュで管理している
  def juice_setup
    refill(Juice.cola,5)
    refill(Juice.water,5)
    refill(Juice.red_bull,5)
  end
  #juiceと在庫数を引き取ってハッシュにしたものを配列に入れる
  #中身は[{name: "cola", price: 120, stock: 5},{・・・}]などになる
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
  #def initialize(name, price)
  #  @name = name
  #  @price = price
  #end
  #上記のように書く事も可能。しかしこの形式の場合は
  #引数を増やすとエラーになる。保守しやすい形を選択している為ハッシュを採用している
  def self.cola
    self.new(name: "cola", price: 120)
    #Juice.new((name: "cola", price: 120)
    #上記二つは同じ意味。selfはJuiceクラスクラス（オブジェクト）を指す
    #selfにしている理由は自分自身のクラスをnewしているとパッと見た時に
    #分かるようにしている。
    #特異メソッドとする事で自身（Juiceクラス）をインスタンス化する。
  end
  def self.water
    self.new(name: "water", price: 100)
  end
  def self.red_bull
    self.new(name: "red_bull", price: 200)
  end
end