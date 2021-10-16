require 'rails_helper'

RSpec.describe 'Microposts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:micropost) { FactoryBot.create(:micropost,user: user) }

  before do
    sign_in_as user
  end

  it 'creates a new micropost' do
    visit new_micropost_path
    fill_in '悩みを投稿してみましょう', with: 'test'
    click_button '投稿する'
    expect(page).to have_current_path root_path
    expect(page).to have_content 'test'
  end


  it 'edits a micropost' do
    visit micropost_path(micropost)
    click_link '編集する'
    fill_in 'content', with: '編集しました'
    click_button '投稿する'
    expect(page).to have_current_path root_path
    expect(page).to have_content '編集しました'
  end

  it 'deletes a micropost', js: true do
    visit micropost_path(micropost)
    click_link '削除する'
    page.accept_confirm
    expect(page).to have_current_path show_users_path(user)
    expect(page).not_to have_content micropost.content
  end

  it 'creates and edits tags' do
    visit new_micropost_path
    fill_in '悩みを投稿してみましょう', with: 'create_tag'
    fill_in 'タグは「,」で区切ってください', with: 'タグ1,タグ2'
    click_button '投稿する'
    click_link 'create_tag'
    expect(page).to have_selector '.badge', text: 'タグ1'
    expect(page).to have_selector '.badge', text: 'タグ2'
    click_link '編集する'
    fill_in 'タグは「,」で区切ってください', with: 'タグ1,タグ3'
    click_button '投稿する'
    click_link 'create_tag'
    expect(page).to have_selector '.badge', text: 'タグ1'
    expect(page).to have_selector '.badge', text: "タグ3"
  end

  it 'checks a anonymous' do
    visit new_micropost_path
    fill_in '悩みを投稿してみましょう', with: '匿名投稿'
    check 'micropost_anonymous'
    click_button '投稿する'
    expect(page).to have_content "匿名希望　さん"
  end

  it 'writes a comment' do
    visit micropost_path(micropost)
    fill_in 'コメントしてみましょう', with: 'コメント'
    click_button 'コメントする'
    expect(page).to have_current_path micropost_path(micropost)
    expect(page).to have_content 'コメント'
  end

end
