class Prefecture < ActiveHash::Base
  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: '北海道' }, # Hokkaido
    { id: 3, name: '青森県' }, # Aomori
    { id: 4, name: '岩手県' }, # Iwate
    { id: 5, name: '宮城県' }, # Miyagi
    { id: 6, name: '秋田県' }, # Akita
    { id: 7, name: '山形県' }, # Yamagata
    { id: 8, name: '福島県' }, # Fukushima
    { id: 9, name: '茨城県' }, # Ibaraki
    { id: 10, name: '栃木県' }, # Tochigi
    { id: 11, name: '群馬県' }, # Gunma
    { id: 12, name: '埼玉県' }, # Saitama
    { id: 13, name: '千葉県' }, # Chiba
    { id: 14, name: '東京都' }, # Tokyo
    { id: 15, name: '神奈川県' }, # Kanagawa
    { id: 16, name: '新潟県' }, # Niigata
    { id: 17, name: '富山県' }, # Toyama
    { id: 18, name: '石川県' }, # Ishikawa
    { id: 19, name: '福井県' }, # Fukui
    { id: 20, name: '山梨県' }, # Yamanashi
    { id: 21, name: '長野県' }, # Nagano
    { id: 22, name: '岐阜県' }, # Gifu
    { id: 23, name: '静岡県' }, # Shizuoka
    { id: 24, name: '愛知県' }, # Aichi
    { id: 25, name: '三重県' }, # Mie
    { id: 26, name: '滋賀県' }, # Shiga
    { id: 27, name: '京都府' }, # Kyoto
    { id: 28, name: '大阪府' }, # Osaka
    { id: 29, name: '兵庫県' }, # Hyogo
    { id: 30, name: '奈良県' }, # Nara
    { id: 31, name: '和歌山県' }, # Wakayama
    { id: 32, name: '鳥取県' }, # Tottori
    { id: 33, name: '島根県' }, # Shimane
    { id: 34, name: '岡山県' }, # Okayama
    { id: 35, name: '広島県' }, # Hiroshima
    { id: 36, name: '山口県' }, # Yamaguchi
    { id: 37, name: '徳島県' }, # Tokushima
    { id: 38, name: '香川県' }, # Kagawa
    { id: 39, name: '愛媛県' }, # Ehime
    { id: 40, name: '高知県' }, # Kochi
    { id: 41, name: '福岡県' }, # Fukuoka
    { id: 42, name: '佐賀県' }, # Saga
    { id: 43, name: '長崎県' }, # Nagasaki
    { id: 44, name: '熊本県' }, # Kumamoto
    { id: 45, name: '大分県' }, # Oita
    { id: 46, name: '宮崎県' }, # Miyazaki
    { id: 47, name: '鹿児島県' }, # Kagoshima
    { id: 48, name: '沖縄県' }  # Okinawa
  ]

  include ActiveHash::Associations
  has_many :items
  has_many :shipping_addresses
end
