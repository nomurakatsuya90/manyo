require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task03) { FactoryBot.create(:task, title: 'task03', content: '内容03', created_at: '2021-03-26 17:03', expired_at: '2021-04-03 16:01') }
  let!(:task01) { FactoryBot.create(:task, title: 'task01', content: '内容01', created_at: '2021-03-26 17:01', expired_at: '2021-04-01 17:02') }
  let!(:task02) { FactoryBot.create(:task, title: 'task02', content: '内容02', created_at: '2021-03-26 17:02', expired_at: '2021-04-02 15:02') }

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
        select '着手中', from: 'status'
        click_button 'commit'
        expect(page).to have_content 'タスク名'
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content '2021-04-01　10:35'
        expect(page).to have_content '着手中'
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
    context '「終了期限でソート」を押下した場合' do
      it '終了期限が早い順番で上から表示される' do
        click_link '終了期限でソート'
        task_list = all('.task_expired_at')
        expect(task_list[0]).to have_content '2021-04-01　17:02'
        expect(task_list[1]).to have_content '2021-04-02　15:02'
        expect(task_list[2]).to have_content '2021-04-03　16:01'
      end
    end
    describe 'タスク管理機能', type: :system do
        describe '検索機能' do
          context 'タイトルであいまい検索をした場合' do
            it "検索キーワードを含むタスクで絞り込まれる" do
              visit tasks_path
              fill_in 'title', with: 'k02'
              click_on 'commit'
              expect(page).to have_content 'task02'
            end
          end
          context 'ステータス検索をした場合' do
            it "ステータスに完全一致するタスクが絞り込まれる" do
              # ここに実装する
              # プルダウンを選択する「select」について調べてみること
            end
          end
          context 'タイトルのあいまい検索とステータス検索をした場合' do
            it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
              # ここに実装する
            end
          end
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