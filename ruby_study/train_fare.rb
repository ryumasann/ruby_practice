# 東京駅から新宿駅までJR山手線に乗って移動します。12歳以上は大人料金で200円、6歳以上12歳未満はこども料金で100円、6歳未満は幼児で無料となります。年齢に応じて東京駅から新宿駅までの料金を出力する関数 train_fare を定義してください。
def train_fare(age)
    if age >= 12
        puts 200
    # 12 > age >= 6のような書き方はできない
    elsif 12 > age && age >= 6
        puts 100
    else
        puts 0
    end
end

train_fare(12)
train_fare(6)
train_fare(5)
