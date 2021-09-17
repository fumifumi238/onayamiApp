require 'rails_helper'

RSpec.describe Like, type: :model do

describe 'like test' do

  let!(:user){User.create(name: "tester",email: "tester@example.com",password: "password")}
  let!(:micropost){Micropost.create(content: "sample")}
  context 'when user_id or micropost_id is nil'do


    it 'is invalid without micropost_id ' do
      like = user.likes.build
      like.valid?
      expect(like).not_to be_valid
    end

    it 'is invalid without user_id ' do
      like = micropost.likes.build
      like.valid?
      expect(like).not_to be_valid
    end


  end


end




end
