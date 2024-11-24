# テーブル設計

## users テーブル

| Column           | Type   | Options                 |
| ---------------- | ------ | ----------------------- |
| nickname         | string | null: false             |
| email            | string | null: false,unique:true |
|encrypted_password| string | null: false             |
| family_name      | string | null: false             |
| first_name       | string | null: false             |
| family_kana      | string | null: false             |
| first_kana       | string | null: false             |
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
| category_id     | integer    | null: false                   |
| status_id       | integer    | null: false                   |
| ship_fee_id     | integer    | null: false                   |
| ship_region_id  | integer    | null: false                   |
| ship_wait_id    | integer    | null: false                   |
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
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| buy           | references | null: false, foreign_key: true |
| post_number   | string     | null: false                    |
| ship_region_id| integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :buy