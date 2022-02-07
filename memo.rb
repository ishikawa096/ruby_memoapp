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
    puts "編集したいメモの番号を入力してください"
    memo_type = gets.to_i
#番号つき一覧表示、選ばれた番号のファイル名を変数に入れる
    open_name = #取得したファイル名
    open_content = CSV.foreach("#{open_name}.csv")
    puts "【ファイル名】#{open_name}" 
    puts "【メモ内容】#{open_content}"
    puts "このメモを編集しますか？"
    puts "1(はい) 2(いいえ)"
    memo_type = gets.to_i
    if memo_type == 1
        puts "編集後の内容を入力してください"
        puts "完了したらCtrl + Dを押します"
        new_content = $stdin.readlines
        CSV.open("#{open_name}.csv" , "r+") do |csv|
            csv << ["#{new_content}"]
        end
        puts "編集が完了しました。アプリを終了します。"
        
    end
    if memo_type == 2
        ##既存のメモ一覧へ戻る？
    end

else 
    puts "1 か 2 を入力してください"
end