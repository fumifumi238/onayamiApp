require 'rails_helper'

RSpec.describe 'Microposts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost) }
  it 'creates a new micropost' do
    sign_in_as user
    visit new_micropost_path
    fill_in '悩みを投稿してみましょう', with: 'test'
    click_button '投稿する'
    expect(page).to have_current_path root_path
    expect(page).to have_content 'test'
  end

  it 'likes a micropost' do
    sign_in_as user
    visit root_path
    click_link micropost.content
    expect(page).to have_css '.like-btn'
    click_link nil, href: micropost_likes_path(micropost)
    expect(page).to have_css '.liked-btn'
    click_link nil, href: micropost_likes_path(micropost)
    expect(page).to have_css '.like-btn'
  end

  it 'writes a comment' do
    sign_in_as user
    visit micropost_path(micropost)
    fill_in 'コメントしてみましょう', with: 'コメント'
    click_button 'コメントする'
    expect(page).to have_current_path micropost_path(micropost)
    expect(page).to have_content 'コメント'
  end
  
end
