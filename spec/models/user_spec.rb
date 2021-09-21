require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with a name, email, and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end


  describe 'name test' do
  let(:user){FactoryBot.build(:user,name: name)}

   context 'when name is nil' do
    let(:name){nil}
     it 'is invalid without a name' do
       user.valid?
       expect(user.errors[:name]).to include("を入力してください")
     end
   end

  context 'when name is longer than 20' do
    let(:name){"a"*21}
     it 'is too long' do
       user.valid?
       expect(user.errors[:name]).to include("は20文字以内で入力してください")
     end
   end

  context 'when name is within 20 words' do
    let(:name){"a"*20}
     it 'is valid with name' do
       user.valid?
       expect(user.errors[:name]).to be_empty
     end
   end

   context 'when name contains blacklist words' do
    let(:name) {"これは不適切な言葉のテストです"}
    it 'is invalid with a blacklist word' do
       user.valid?
       expect(user.errors[:contain_blacklist_words]).to include(": 不適切な言葉が含まれています。")
     end

   end

  context 'when name contains 5 consecutive characters' do
    let(:name) {"あ"*5}
    it 'is invalid with 5 consecutive characters' do
       user.valid?
       expect(user.errors[:contain_invalid_regex]).to include(": url,htmlタグ,5文字以上の連続した単語は使えません。")
     end

   end

  context 'when name contains html' do
    let(:name) {"<h1>test</h1>"}
    it 'is invalid with html tag' do
       user.valid?
       expect(user.errors[:contain_invalid_regex]).to include(": url,htmlタグ,5文字以上の連続した単語は使えません。")
     end

   end

  context 'when name contains url' do
    let(:name) {"https://www.google.co.jp"}
    it 'is invalid with url' do
       user.valid?
       expect(user.errors[:contain_invalid_regex]).to include(": url,htmlタグ,5文字以上の連続した単語は使えません。")
     end

   end

  end


 describe 'email test' do
    let!(:created_user){FactoryBot.create(:user,email: "tester@example.com")}
    let(:user){FactoryBot.build(:user,email: email)}


    context 'duplicate email' do
      let(:email){ "tester@example.com"}
          it 'is invalid with a duplicate email address' do
           user.valid?
           expect(user.errors[:email]).to include("はすでに存在します")

          end
     end

    context 'email is nil' do
      let(:email){nil}
    it 'is invalid without an email address' do
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
  end

end

   it 'is not invalid with a duplicate name' do
  User.create(
     name:  "Tester",
     email:      "tester@example.com",
     password:   "dottle-nouveau-pavilion-tights-furze",
   )

   user = User.new(
     name:  "Tester",
     email:      "another_tester@example.com",
     password:   "dottle-nouveau-pavilion-tights-furze",
   )

   user.valid?
   expect(user).to  be_valid
   end

   describe 'password test' do
       let(:user) { User.new(params) }
       let(:params) { { name: "tester", email: "tester@example.com", password: password} }

    context 'password is shorter than 8' do
      let(:password){"1"*7}
      it 'is too short' do
        user.valid?
        expect(user.errors[:password]).to include("は8文字以上で入力してください")
      end
    end

    context 'password is longer than 128' do
      let(:password){"1"*129}
      it 'is too long' do
        user.valid?
        expect(user.errors[:password]).to include("は128文字以内で入力してください")
      end
    end

    context 'password is nil' do
      let(:password){nil}
      it 'is blank' do
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
    end

   end




end
