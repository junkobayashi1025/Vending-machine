class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @insert_money = 120
    @sales_amount = 0
    @drinks = [{name: "コーラ", price: 120, stock: 5}]
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
    puts "現在、購入できるのは以下の通りです。"
    @drinks.each_with_index do |drink, idx|
    puts "No.#{idx+1}  名前:#{drink[:name]}  値段:#{drink[:price]}  在庫:#{drink[:stock]}本"
    end
    puts "どれを購入しますか？"
    n = gets.to_i
    if @insert_money >= @drinks[n-1][:price] && @drinks[n-1][:stock] > 0
      puts "ガラン"
      sleep(1)
      puts "ゴロン"
      sleep(1)
      puts "ガラン！！！"
      sleep(1)
      puts "勇者は'#{@drinks[n-1][:price]}円'と引き換えに'#{@drinks[n-1][:name]}'を手にいれた！"
      @drinks[n-1][:stock] -= 1
      @insert_money -= @drinks[n-1][:price]
      @sales_amount += @drinks[n-1][:price]
      refund_money

    elsif @insert_money < @drinks[n-1][:price]
      puts "投入金額が足りません。お金を入れてください。"
    else
      puts "Sold Out"
    end
  end

  def sales_amount_info
    puts "現在の総売り上げは#{@sales_amount}円です。"
  end

  def drink_add(name, price)
    @drinks.push({name: name, price: price, stock: 5})
  end

  def drink_info
    @drinks.each_with_index do |drink, idx|
      puts "No.#{idx+1}  名前:#{drink[:name]}  値段:#{drink[:price]}  在庫:#{drink[:stock]}本"
    end
  end
end

# require './vend.rb'
# vm = VendingMachine.new

# 1000円投入する
# vm.insert_money (1000)

# 投入金額の確認
# vm.inset_money_info

# 売上金額の確認
# vm.sales_amount_info

# ドリンクの情報確認
# vm.drink_info

# 投入金額の払い戻し
# vm.refund_money

# ドリンク購入
# vm.purchase

# ドリンクの追加
# vm.drink_add("水", 100)
# vm.drink_add("レッドブル", 200)
