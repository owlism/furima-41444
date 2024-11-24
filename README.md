# テーブル設計

## users テーブル

| Column           | Type   | Options                 |
| ---------------- | ------ | ----------------------- |
| nickname         | string | null: false             |
| email            | string | null: false,unique:true |
| password         | string | null: false             |
| name             | string | null: false             |
| phone_number     | integer| null: false             |
| birth_date       | date   | null: false             |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column          | Type       | Options                       |
| --------------- | ---------- | ----------------------------- |
| user            | references | null:false, foreign_key: true |
| name            | string     | null: false                   |
| description     | text       | null: false                   |
| category        | string     | null: false                   |
| price           | integer    | null: false                   |

### Association

- belongs_to :user
- has_one :buy


## buys テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item