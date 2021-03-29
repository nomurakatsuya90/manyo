# README
**テーブル定義**
**■User**

| カラム名 | データ型 | 制約 | キー   |
| -------- | -------- | ---- | ------ |
| id       | bigint   | -    | 主キー |
| name     | string   | -    | -      |

**■Task**

| カラム名   | データ型 | 制約     | キー     |
| ---------- | -------- | -------- | -------- |
| id         | bigint   | -        | 主キー   |
| user_id    | string   | -        | 外部キー |
| title      | string   | NOT NULL | -        |
| content    | string   | NOT NULL | -        |
| expired_at | datetime | -        | -        |
| priority   | integer  | -        | -        |
| status     | integer  | -        | -        |

**■TaskLabel**

| カラム名 | データ型 | 制約 | キー     |
| -------- | -------- | ---- | -------- |
| task_id  | integer  | -    | 外部キー |
| label_id | integer  | -    | 外部キー |

**■Label**

| カラム名 | データ型 | 制約 | キー   |
| -------- | -------- | ---- | ------ |
| id       | bigint   | -    | 主キー |
| memo     | string   | -    | -      |

**Herokuへのデプロイ手順**
1. アセットプリコンパイルをする
  $ rails assets:precompile RAILS_ENV=production

2. Heroku上にアプリ作成
  $ heroku create
  
3. Ruby2.6.5では最新版stack上で動作しない可能性があるためheroku-18に指定
  $ heroku stack:set heroku-18
  
4. stackの変更を確認
  $ heroku stack
   ★heroku-18になっていることを確認
   
5. buildpackを追加
  $ heroku buildpacks:set heroku/ruby
  $ heroku buildpacks:add --index 1 heroku/nodejs

6. Herokuへデプロイ(push)
  ①ローカルmasterをデプロイする場合
​    $ git push heroku master
  ②ローカル 開発ブランチ(例：step2)をデプロイする場合
​    $ git push heroku step2:master

7. HerokuでのDBマイグレーション実行
  $ heroku run rails db:migrate

★更新する場合は、上記6.再pushを行う。
　(DB変更を行った場合は7.Heroku上でのマイグレーション実行も併せて行う。)
　※手順1.はpush時にHeroku側で自動実行される。