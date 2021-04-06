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
      it 'ログアウトができる' do
        click_link 'Logout'
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '管理者画面の機能' do
    context '一般ユーザーの場合' do
      it '管理者画面へアクセスするとタスク一覧画面に遷移' do
        visit new_session_path
        fill_in 'session_email', with: 'user01@example.jp'
        fill_in 'session_password', with: 'pass1234'
        click_on 'commit'
        sleep(0.5)
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end
    context '管理ユーザーの場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'admin01@example.jp'
        fill_in 'session_password', with: 'pass1234'
        click_on 'commit'
      end
      it '管理者画面にアクセスできる' do
        sleep(0.5)
        click_link '管理者画面へ'
        sleep(0.5)
        expect(page).to have_content '管理者画面'
      end
      it 'ユーザーの新規登録ができる' do
        click_link '管理者画面へ' 
        click_link 'ユーザーの新規登録'
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_on 'ユーザーの登録'
        sleep(0.5)
        expect(page).to have_content 'ユーザ「test」を登録しました'     
      end
      it 'ユーザーの詳細画面へアクセスできる' do
        visit admin_user_path(user01.id)
        expect(page).to have_content 'ユーザ詳細画面'
        expect(page).to have_content 'user01'
      end
    #   it 'ユーザの編集画面でユーザを編集できる' do
    #     visit admin_users_path
    #     all('tbody tr')[0].click_on 'ユーザの編集'
    #     fill_in 'Name', with: 'edit_test'
    #     fill_in 'Email', with: 'edit_test@example.com'
    #     choose 'user_admin_true'
    #     click_on '変更する'
    #     expect(page).to have_content 'ユーザーを編集しました'
    #   end
    #   it 'ユーザーの削除ができる' do
    #     visit admin_users_path
    #     all('tbody tr')[0].click_on 'ユーザの削除'
    #     page.driver.browser.switch_to.alert.accept
    #     expect(page).to have_content 'ユーザーを削除しました'
    #   end
    end
  end
end
