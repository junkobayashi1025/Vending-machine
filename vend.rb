class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @insert_money = 0
    @sales_amount = 0
    @drinks = Drink.new
    @status = Customer.new
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
      puts "勇者は'#{@drinks.drink[n-1][:price]}円'と引き換えに'#{@drinks.drink[n-1][:name]}'を手にいれた！"
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
  def sales_amount_info
    puts "現在の総売り上げは#{@sales_amount}円です。"
  end
end

class Drink
  attr_reader :drink

  def initialize
    @drink = [{name: "コーラ", price: 120, stock: 5}]
  end

  def add(name, price)
    @drink.push({name: name, price: price, stock: 5})
  end

  def info
    @drink.each_with_index do |drink, idx|
      puts "No.#{idx+1}  名前:#{drink[:name]}  値段:#{drink[:price]}  在庫:#{drink[:stock]}本"
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
     @status = {job:"勇者", money_in_hand: 1000, HP: 100}
   when 2
     @status = {job:"魔法少女", money_in_hand: 800, HP: 80}
   else 3
     @status = {job:"遊び人", money_in_hand: 200, HP: 10}
   end
 end

 def info
   puts "職業:#{@status[:job]}  所持金:#{@status[:money_in_hand]}  HP:#{@status[:HP]}"
 end
end

# require './vend.rb'

# customer = Customer.new
# customer.info

# vm = VendingMachine.new

# drink = Drink.new
# drink.add("水", 100)
# drink.add("レッドブル", 200)
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
