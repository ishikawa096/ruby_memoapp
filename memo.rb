require "csv"
require "find"
 
puts "1(新規でメモを作成) 2(既存のメモ編集する)"

memo_type = gets.to_i

# 1なら"拡張子を除いたファイル名を入力してください"　
# ファイル名入力後"メモしたい内容を記入してください" "完了したらCtrl + Dを押します"

# 2なら"既存のメモを表示します"編集したいメモの番号を入力してください"
# 選ばれたメモを開く "編集が完了したらCtrl + Dを押します"

if memo_type == 1
    puts "拡張子を除いたファイル名を入力してください" 
    memo_name = gets.chomp
    if File.exist?("#{memo_name}.csv")
        puts "既に同じ名前のファイルがあります。"
        puts "1(別のファイル名を入力) 2(#{memo_name}.csvを上書きする)"
        memo_type = gets.to_i
        if memo_type == 1
            ##1ならファイル名入力に戻る、2なら編集モードで開く
        end
        #if memo_type == 2

        #end
    end
    puts "メモしたい内容を記入してください"
    puts "完了したらCtrl + Dを押します"
    memo_content = readlines
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
    puts "上記メモを作成しました。アプリを終了します。"
elsif memo_type == 2
    puts "既存のメモを表示します"
    puts "------------------"
    #puts "編集したいメモの番号を入力してください"
    #memo_type = gets.to_i
#番号つき一覧表示、選ばれた番号のファイル名を変数に入れる
    Find.find('.') do |item|
        puts item
    end
    #open_name = #取得したファイル名
    puts "------------------"
    while memo_type < 3 do
        puts "開きたいファイル名を拡張子を除いて入力してください。"
        begin
            open_name = gets.chomp ##ファイル名を手動入力
            open_content = CSV.foreach("#{open_name}.csv")
            puts "------------------"
            puts "【ファイル名】"
            puts open_name
            puts "【メモ内容】"
            open_content.each do |content|
                puts content
            end
        rescue
            puts $!
            puts "ファイルを開けませんでした。"
            puts "もう一度お願いします。"
            next
        end
        puts "------------------"
        puts "このメモを編集しますか？"
        puts "1(はい) 2(いいえ) 3他(キャンセルして終了)"
        memo_type = gets.to_i
        if memo_type == 1
            puts "編集後の内容を入力してください"
            puts "完了したらCtrl + Dを押します"
            new_content = readlines
            CSV.open("#{open_name}.csv","w") do |csv|
                new_content.each do |content|
                    write_content = content.chomp
                    csv << [ write_content ]
                end
            end
            puts ""
            puts "------------------"
            puts "【ファイル名】"
            puts open_name
            puts "【メモ内容】"
            new_content.each do |content|
                puts content
            end
            puts "------------------"
            puts "編集が完了しました。アプリを終了します。"
            break
        elsif memo_type == 2
            next
        else
            puts "アプリを終了します。"
            next
        end
    end

else 
   puts "1か2を入力してください"
end