require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name, email, and password' do
    user = User.new(
      name: 'Aaron',
      email: 'tester@gmail.com',
      password: 'dottle-nouveau-pavilion-tights-furze',
      password_confirmation: 'dottle-nouveau-pavilion-tights-furze'
    )
    expect(user).to be_valid
  end
  # 名がなければ無効な状態であること
  it 'is invalid without a first name' do
   user = User.new(name: nil)
   user.valid?
  expect(user.errors[:name]).to include("を入力してください")
  end

  # メールアドレスがなければ無効な状態であること
  it 'is invalid without an email address' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
  User.create(
     name:  "Tester",
     email:      "tester@example.com",
     password:   "dottle-nouveau-pavilion-tights-furze",
   )

   user = User.new(
     name:  "Tester",
     email:      "tester@example.com",
     password:   "dottle-nouveau-pavilion-tights-furze",
   )

   user.valid?
   expect(user.errors[:email]).to include("はすでに存在します")

  end


end
