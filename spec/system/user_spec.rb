require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user01) {FactoryBot.create(:user01)}
  let!(:admin01) {FactoryBot.create(:admin01)}

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーのプロフィールが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'new_user'
        fill_in 'user_email', with: 'new@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'Create my account'
        expect(page).to have_content 'new_userのページ'
      end
    end

    context 'ログインせずにタスク一覧画面へアクセスした場合' do
        it 'ログイン画面に遷移する' do
          visit tasks_path
          expect(page).to have_content 'Log in'
        end
    end
  end

  describe 'セッション機能' do
    context 'ユーザーが登録されている場合' do
        it 'ログインができる' do
          visit new_session_path
          fill_in 'session_email', with: 'user01@example.jp'
          fill_in 'session_password', with: 'pass1234'
          click_on 'commit'
          expect(page).to have_content '一般ユーザー01のページ'
        end
    end
    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'user01@example.jp'
        fill_in 'session_password', with: 'pass1234'
        click_on 'commit'
      end
        it '自分のプロフィール画面に遷移' do
          visit user_path(user01.id)
          expect(page).to have_content '一般ユーザー01のページ'
        end
        it '他人の詳細画面にアクセスするとタスク一覧画面に遷移' do
          visit user_path(admin01.id)
          expect(page).to have_content 'タスク一覧'
        end
  #       it 'ログアウトができる' do
  #         click_link 'Logout'
  #         expect(page).to have_content 'ログアウトしました'
  #       end
    end
  end
end