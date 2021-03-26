# README
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