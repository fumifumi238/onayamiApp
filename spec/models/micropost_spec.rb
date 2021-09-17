require 'rails_helper'

RSpec.describe Micropost, type: :model do

describe 'content test' do
  let(:micropost){Micropost.new(params)}
  let(:params){{content: content}}

  context 'when content or user_id is nil' do
   let(:content){nil}
    it 'is invalid without a content' do
      micropost.valid?
      expect(micropost.errors[:content]).to include("を入力してください")
    end

   it 'is invalid without a content' do
      micropost.valid?
      expect(micropost.errors[:user]).to include("を入力してください")
    end
  end

  context 'when content is nil' do
   let(:content){"aiueo"*201}
    it 'is invalid without a content' do
      micropost.valid?
      expect(micropost.errors[:content]).to include("は1000文字以内で入力してください")
    end
  end

  context 'when content contains blacklist words' do
   let(:content) {"これは不適切な言葉のテストです"}
   it 'is invalid with a blacklist word' do
      micropost.valid?
      expect(micropost.errors[:contain_blacklist_words]).to include(": 不適切な言葉が含まれています。")
    end

  end

  context 'when content contains 5 consecutive characters' do
   let(:content) {"あああああ"}
   it 'is invalid with 5 consecutive characters' do
      micropost.valid?
      expect(micropost.errors[:contain_invalid_regex]).to include(": url,htmlタグ,5文字以上の連続した単語は使えません。")
    end

  end

  context 'when content contains html' do
   let(:content) {"<h1>test</h1>"}
   it 'is invalid with html tag' do
      micropost.valid?
      expect(micropost.errors[:contain_invalid_regex]).to include(": url,htmlタグ,5文字以上の連続した単語は使えません。")
    end

  end

  context 'when content contains url' do
   let(:content) {"https://www.google.co.jp"}
   it 'is invalid with url' do
      micropost.valid?
      expect(micropost.errors[:contain_invalid_regex]).to include(": url,htmlタグ,5文字以上の連続した単語は使えません。")
    end

end


   end



end
