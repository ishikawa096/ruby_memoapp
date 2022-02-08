require "csv"
require "find"
flag = 0
flagB = 0
file_count = 0

def csv_write(memo_name,memo_content)
  CSV.open("#{memo_name}.csv","w") do |csv|
    memo_content.each do |content|
      write_content = content.chomp
      csv << [ write_content ]
    end
  end
  puts "------------------"
  puts "【ファイル名】"
  puts memo_name
  puts "【メモ内容】"
  memo_content.each do |content|
    puts content
  end
  puts "------------------"
end

def csv_show(memo_name)
  puts "------------------"
  puts "【ファイル名】"
  puts memo_name
  puts "【メモ内容】"
  exi_content = CSV.foreach("#{memo_name}.csv")
  exi_content.each do |content|
    puts content
  end
  puts "------------------"
end

while flag == 0 do
  flagB = 0
  puts "1(新規メモを作成) 2(既存のメモを編集) 3その他(アプリを閉じる)"
  memo_type = gets.to_i
  if memo_type == 1
    puts "拡張子を除いたファイル名を入力してください。" 
    memo_name = gets.chomp
    if File.exist?("#{memo_name}.csv")
      puts "既に同じ名前のファイルがあります。"
      csv_show(memo_name)
      puts "1(戻る) 2その他(#{memo_name}.csvを上書きする)"
      key = gets.to_i
      if key == 1
        puts "選択画面に戻ります。"
        next
      else
        puts "編集後の内容を入力してください"
        puts "完了したらCtrl + Dを押します"
        memo_content = readlines
        csv_write(memo_name,memo_content)
        puts "編集が完了しました。選択画面に戻ります。"
        next
      end
    end
    puts "メモしたい内容を記入してください"
    puts "完了したらCtrl + Dを押します"
    memo_content = readlines
    csv_write(memo_name,memo_content)
    puts "メモの作成が完了しました。選択画面に戻ります。"
    next

  elsif memo_type == 2
    puts "既存のメモを表示します。"
    puts ""
    Find.find('.') do |item|
      base = File.basename(item)
      ext = File.extname(item)
      if ext == ".csv"
        file_count += 1
        puts "   #{base}"
      end
    end
    puts ""
    if file_count == 0
      puts "メモが見つかりませんでした。選択画面に戻ります。"
      next
    end
    while flagB == 0 do
      puts "開きたいファイル名を拡張子を除いて入力してください。"
      begin
        memo_name = gets.chomp
        csv_show(memo_name)
      rescue
        puts $!
        puts "ファイルを開けませんでした。"
        puts "もう一度お願いします。"
        next
      end
      puts "このメモを編集しますか？"
      puts "1(はい) 2(いいえ) 3その他(選択画面に戻る)"
      key = gets.to_i
      if key == 1
        puts "編集後の内容を入力してください"
        puts "完了したらCtrl + Dを押します"
        memo_content = readlines
        csv_write(memo_name,memo_content)
        puts "編集が完了しました。選択画面に戻ります。"
        flagB = 1  
      elsif key == 2
        next
      else
        puts "選択画面に戻ります。"
        flagB = 1
        break
      end
    end

  else 
    puts "アプリを終了します。"
    flag = 1
    break
  end
end