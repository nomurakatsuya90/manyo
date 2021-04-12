require 'rails_helper'
RSpec.describe 'ラベル登録機能', type: :system do

  def login(user)
    visit new_session_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_on 'commit'
    sleep(0.5)
    visit tasks_path 
  end

  # before do
  #   user = FactoryBot.create(:task_user)
  #   login(user)
  #   FactoryBot.create(:label)　★ココ
  #   FactoryBot.create(:second_label)　★ココ
  #   visit new_task_path
  # end

  describe 'ラベル新規作成機能' do
    context 'ラベルを選択した場合' do
      it 'ラベルが表示される' do
        user = FactoryBot.create(:user01)
        login(user)
        FactoryBot.create(:label01)
        FactoryBot.create(:label02)
        visit new_task_path
        fill_in 'task_title', with: 'タスク名'
        fill_in 'task_content', with: 'タスク詳細'
        fill_in :task_expired_at, with: '2021-04-01 10:35'.to_datetime
        select '着手中', from: 'status'
        select '中', from: 'priority'
        check 'LABEL01'
        click_button 'commit'
        expect(page).to have_content 'タスク名'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '2021-04-01　10:35'
        expect(page).to have_content '着手中'
        expect(page).to have_content '中'
        expect(page).to have_content 'LABEL01'
      end
    end
  end

  # describe '詳細確認機能' do
  #   context '詳細画面に遷移した場合' do
  #     it 'ラベルが表示される' do
  #       user = FactoryBot.create(:task_user2)
  #       login(user)
  #       label = FactoryBot.create(:label01)
  #       visit new_task_path
  #       fill_in 'Title', with: 'aaa'
  #       fill_in 'Details', with: 'bbb'
  #       fill_in :task_expired_at, with: '002021-03-17　11:39'
  #       select '未着手', from: 'status'
  #       select '中', from: 'priority'
  #       check 'Task1'  
  #       click_on 'Create Task' 
  #       click_on '詳細画面'
  #       expect(page).to have_content 'Task1'
  #     end
  #   end
  # end

  # describe '検索機能' do
  #   context 'ラベルで検索した場合' do
  #     it '検索結果が表示される' do
  #      user = FactoryBot.create(:other_user1)
  #      login(user)
  #      label = FactoryBot.create(:label02)
  #      visit new_task_path
  #      fill_in 'Title', with: 'aaa'
  #      fill_in 'Details', with: 'bbb'
  #      fill_in :task_expired_at, with: '002021-03-17　11:39'
  #      select '未着手', from: 'status'
  #      select '中', from: 'priority'
  #      check 'Task2'  
  #      click_on 'Create Task'
  #      select 'Task2'
  #      click_on 'search'
  #      expect(page).to have_content 'Task2'
  #     end
  #   end
  # end
end