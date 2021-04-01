require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task03) { FactoryBot.create(:task, title: 'task03', content: '内容03', created_at: '2021-03-26 17:03') }
  let!(:task01) { FactoryBot.create(:task, title: 'task01', content: '内容01', created_at: '2021-03-26 17:01') }
  let!(:task02) { FactoryBot.create(:task, title: 'task02', content: '内容02', created_at: '2021-03-26 17:02') }

  before do
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: 'タスク名'
        fill_in "task_content", with: 'タスク詳細'
        fill_in :task_expired_at, with: '2021-04-01 10:35'.to_datetime
        click_button 'commit'
        expect(page).to have_content 'タスク名'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '2021-04-01　10:35'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # ページ遷移直後でデバッグ
        # binding.irb
        # タスク一覧ページに遷移できているかをデバッグ
        current_path
        # タスクがデータベースに作成されているかをデバッグ
        Task.count
        # 表示するHTMLにタスク情報が入っているかをデバッグ
        page.html
        expect(page).to have_content 'task01'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_title')
        expect(task_list[0]).to have_content 'task03'
        expect(task_list[1]).to have_content 'task02'
        expect(task_list[2]).to have_content 'task01'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        click_link 'taskの詳細', match: :first
        #登録タスクの内容が表示
        expect(page).to have_content 'task03'   
       end
     end
  end
end