class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :drinks

  def initialize
    @insert_money = 0
    @sales_amount = 0
    @drinks = Drink.new
  end

  def insert_money(money)
    if MONEY.include?(money)
      @insert_money += money
      puts "現在の投入金額は#{@insert_money}円です。"
    else
      puts "このお金は使えません。"
    end
  end

  def inset_money_info
    puts "現在の投入金額は#{@insert_money}円です。"
  end

  def refund_money
    puts "投入金額#{@insert_money}円を払い戻しいたします。"
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


# require './vend.rb'

# vm = VendingMachine.new
# vm.drinks.add("水", 100)
# vm.drinks.add("レッドブル", 200)
# vm.drinks.info

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
