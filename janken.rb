is_after_drew = false
is_end = false
hands = ["グー","チョキ","パー"]

def acchihoi(case_pattern)
  case case_pattern
  when "user_first"
    puts "あなた:あっち向いて〜"
    user_act, bot_act = acchihoi_process
    if user_act == bot_act
      puts "あなたの勝ち！"
      puts "相手:不覚〜！"
      is_end = true
      return is_end
    else
      is_end = false
      return is_end
    end
  when "bot_first"
    puts "相手:あっち向いて〜"
    user_act, bot_act = acchihoi_process
    if user_act == bot_act
      puts "あなたの負け！"
      puts "相手:やったー！"
      is_end = true
      return is_end
    else
      is_end = false
      return is_end
    end
  end
end

def acchihoi_process
  puts "0(上) 1(下) 2(左) 3(右)"
  user_act = gets.to_i
  puts "ホイ！"
  puts "---------------"
  directions = ["上","下","左","右"]
  if user_act > 3
    user_act = [0,1,2,3].sample
    user_dir = directions[user_act]
    puts "相手:それは#{user_dir}だな！？"
  else
    user_dir = directions[user_act]
  end
  bot_act = [0,1,2,3].sample
  bot_dir = directions[bot_act]
  puts "あなた:#{user_dir}"
  puts "相手:#{bot_dir}" 
  return user_act,bot_act
end

while is_end == false
  if is_after_drew == false
    puts "じゃんけん..."
  end
  puts "0(グー) 1(チョキ) 2(パー) 3(戦わない)"
  user_act = gets.to_i
  if user_act == 3
    puts "またね！"
    break
  end
  if is_after_drew == false
    puts "ホイ！"
  else
    puts "ショ！"
    is_after_drew = false
  end
  puts "---------------"
  if user_act > 3
    user_act = [0,1,2].sample
    user_hand = hands[user_act]
    puts "相手:それは#{user_hand}だな！？"
  else
    user_hand = hands[user_act]
  end
  bot_act = [0,1,2].sample
  bot_hand = hands[bot_act]
  puts "あなた:#{user_hand}を出しました"
  puts "相手:#{bot_hand}を出しました" 
  if user_act == bot_act
    puts "あいこで..."
    is_after_drew = true
  elsif (user_act == 0 && bot_act == 1) || (user_act == 1 && bot_act == 2) || (user_act == 2 && bot_act == 0)
    is_end = acchihoi("user_first")
  elsif (user_act == 0 && bot_act == 2) || (user_act == 1 && bot_act == 0) || (user_act == 2 && bot_act == 1)
    is_end = acchihoi("bot_first")
  end
end