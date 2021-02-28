class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize(drink, customer, drink_stock)
    @insert_money = 0
    @sales_amount = 0
    @drinks = drink
    @status = customer
    @drink_stock = drink_stock
  end

  def insert_money(money)
    if MONEY.include?(money)
      @insert_money += money
      @status.status[:money_in_hand] -= money
      puts "現在の投入金額は#{@insert_money}円です。"
      puts "現在の所持金は#{@status.status[:money_in_hand]}円です。"
    else
      puts "このお金は使えません。"
    end
  end

  def inset_money_info
    puts "現在の投入金額は#{@insert_money}円です。"
  end

  def refund_money
    puts "投入金額#{@insert_money}円を払い戻しいたします。"
    @status.status[:money_in_hand] += @insert_money
    puts "現在の所持金は#{@status.status[:money_in_hand]}円です。"
    puts "また来てね"
    @insert_money = 0
  end

  def purchase
    while true
      puts "現在、購入できるのは以下の通りです。"
      @drinks.drink.each_with_index do |drink, idx|
      puts "No.#{idx+1}  名前:#{drink[:name]}  値段:#{drink[:price]}  在庫:#{drink[:stock]}本"
      end
      puts "どれを購入しますか？"
      n = gets.to_i
      if @insert_money >= @drinks.drink[n-1][:price] && @drinks.drink[n-1][:stock] > 0
        puts "ガラン"
        sleep(1)
        puts "ゴロン"
        sleep(1)
        puts "ガラン！！！"
        sleep(1)
        puts "'#{@status.status[:job]}'は'#{@drinks.drink[n-1][:price]}円'と引き換えに'#{@drinks.drink[n-1][:name]}'を手にいれた！"
        @drinks.drink[n-1][:stock] -= 1
        @insert_money -= @drinks.drink[n-1][:price]
        @sales_amount += @drinks.drink[n-1][:price]
        puts "まだ買いますか？"
        puts "Yse!(1) or No(2)"
        n = gets.to_i
          if n == 2
            refund_money
            break
          else
            true
          end
      elsif @insert_money < @drinks.drink[n-1][:price]
        puts "投入金額が足りません。お金を入れてください。"
      else
        puts "Sold Out"
      end
    end
  end

  def drink_or_stock?(n)
    puts "今、飲みますか？それとも取っておきますか？"
    puts "飲む(1) or 取っておく(2)"
    num = gets.to_i
    case num
    when 1
      puts "何を飲みますか？"
      puts "飲み物一覧"
      @drink_stock.stock_idx.each_with_index do |drink, idx|
      puts "No.#{idx+1}  名前:#{drink[:name]}  保有数:#{drink[:stock]}本"
      end
      num_1 = gets.to_i
      puts "ゴクッ"
      sleep(1)
      puts "ゴクッ、ゴクッ"
      sleep(1)
      puts "プハ～！！！"
      sleep(1)
      puts "'#{@status.status[:job]}'は'#{@drink_stock.stock_idx[num_1-1][:name]}'を飲んだ！"
      # puts "'#{@status.status[:job]}'はHP:'#{@drinks.drink[num_1-1][:hp_up]}'回復した！"　　　　　修正必要
      # puts "#{@drinks_stock.stock_idx.[num_1-1][:name]}'を1本消費した！"
    when 2
      # 修正必要
      puts "'#{@status.status[:job]}'は'#{@drinks.drink[n-1][:name]}'をバッグに入れた！"
      @drink_stock.stock_idx.push({name: @drinks.drink[n-1][:name], stock: 1})
    else
    end
  end

  def sales_amount_info
    puts "現在の総売り上げは#{@sales_amount}円です。"
  end
end

class Drink
  attr_reader :drink
  def initialize
    @drink = [{name: "コーラ", price: 120, hp_up: 30, stock: 5}]
  end

  def add(name, price, hp_up)
    @drink.push({name: name, price: price, hp_up: hp_up, stock: 5})
  end

  def info
    @drink.each_with_index do |drink, idx|
      puts "No.#{idx+1}  名前:#{drink[:name]}  値段:#{drink[:price]}  在庫:#{drink[:stock]}本"
    end
  end
end

class DrinkStock
 attr_reader :stock_idx

 def initialize
  @stock_idx = [{name: "水", stock: 1}]
 end

 def info
   puts "現在、保有しているドリンクは以下の通りです。"
   @stock_idx.each_with_index do |drink, idx|
   puts "No.#{idx+1}  名前:#{drink[:name]}  保有数:#{drink[:stock]}本"
   end
 end
end

class Customer
  attr_reader :status

 def initialize
   puts "職業を以下から選んでください"
   puts "No.1 勇者　No.2 魔法少女 No.3 遊び人"
   num = gets.to_i
   case num
   when 1
     @status = { job:"勇者", money_in_hand: 1000, stock_drink:0, HP: 100 }
   when 2
     @status = { job:"魔法少女", money_in_hand: 800, stock_drink:0, HP: 80 }
   when 3
     @status = { job:"遊び人", money_in_hand: 200, stock_drink:0, HP: 10 }
   end
 end

 def info
   puts "職業:#{@status[:job]}  所持金:#{@status[:money_in_hand]}  ドリンク数:#{@status[:stock_drink]}本  HP:#{@status[:HP]}"
 end
end

class Start
  def self.start
    drink_stock = DrinkStock.new
    customer = Customer.new
    drink = Drink.new
  end
end




# require './vend.rb'

# start = Start.new
# drink_stock = DrinkStock.new
# customer = Customer.new
# drink = Drink.new
# vm = VendingMachine.new(drink, customer, drink_stock)
# # customer.info
# vm.drink_or_stock?(1)
# vm = VendingMachine.new(drink, customer, drink_stock)

#
# drink_stock.info

# drink.add("水", 100, 10)
# drink.add("レッドブル", 200, 100)
# drink.info

# 1000円投入する
# vm.insert_money (1000)

# 投入金額の確認
# vm.inset_money_info

# 売上金額の確認
# vm.sales_amount_info

# 投入金額の払い戻し
# vm.refund_money

# ドリンク購入
# vm.purchase
