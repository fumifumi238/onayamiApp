require 'rails_helper'

# todo adminのテスト
RSpec.describe 'Users', type: :system do

  describe "user" do
    let(:user) { FactoryBot.create(:user) }
    it 'logged in as a user' do
      sign_in_as user
      expect(page).to have_current_path "/users/#{user.id}"
      click_link 'ログアウト'
    end

    it 'edits  a user ' do
      sign_in_as user
      visit show_users_path(user)
      click_link 'アカウント編集'
      fill_in 'ユーザー名', with: 'foo'
      fill_in 'パスワード', with: 'foobarbaz'
      fill_in 'パスワード（確認用）', with: 'foobarbaz'
      fill_in '現在のパスワード', with: user.password
      click_button '更新'
      expect(page).to have_current_path root_path
    end

  end

  describe "admin" do
    let(:admin) {FactoryBot.create(:user,:admin) }
    let!(:user) {FactoryBot.create(:user)}
    let!(:micropost){FactoryBot.create(:micropost,user: user)}

    before do
      sign_in_as admin
    end

    it "logged in as an admin" do
      expect(page).to have_current_path users_index_path
      click_link 'ログアウト'
    end

    it "deletes other people's micropost if admin",js: true do
      expect(page).to have_current_path users_index_path
      expect(page).to have_content user.name
      click_link user.name
      click_link '削除する'
      page.accept_confirm
    end


  end


end


# 1 # 全種類の HTML 要素を扱う
# 2 it "works with all kinds of HTML elements" do
# 3 # ページを開く
# 4 visit "/fake/page"
# 5 # リンクまたはボタンのラベルをクリックする
# 6 click_on "A link or button label"
# 7 # チェックボックスのラベルをチェックする
# 8 check "A checkbox label"
# 9 # チェックボックスのラベルのチェックを外す
# 10 uncheck "A checkbox label"
# 11 # ラジオボタンのラベルを選択する
# 12 choose "A radio button label"
# 13 # セレクトメニューからオプションを選択する
# 14 select "An option", from: "A select menu"
# 15 # ファイルアップロードのラベルでファイルを添付する
# 16 attach_file "A file upload label", "/some/file/in/my/test/suite.gif"
# 17
# 18 # 指定した CSS に一致する要素が存在することを検証する
# 19 expect(page).to have_css "h2#subheading"
# 20 # 指定したセレクタに一致する要素が存在することを検証する
# 21 expect(page).to have_selector "ul li"
# 22 # 現在のパスが指定されたパスであることを検証する
# 23 expect(page).to have_current_path "/projects/new"
# 24 end
