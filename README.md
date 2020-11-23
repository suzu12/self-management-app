# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association

- has_many :user_teams
- has_many :teams, through: user_teams
- has_many :chats
- has_one :profile


## teams テーブル

| Column        | Type       | Options           |
| ------------- | -----------| ------------------|
| category_id   | integer    | null: false       |
| team_name     | string     | null: false       |
| introduction  | text       | null: false       |
| period_id     | integer    | null: false       |

### Association

- has_many :user_teams
- has_many :users, through: user_teams
- has_many :chats

## user_teams テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ------------------|
| user    | references | foreign_key: true |
| team    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :team

## chats テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| content | string     | null: false       |
| user    | references | foreign_key: true |
| team    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :team

## profiles テーブル

| Column   | Type       | Options     |
| -------- | ---------- | ----------- |
| bio      | text       | null: false |
| birthday | date       | null: false |
| gender   | integer    | null: false |
| user     | references | null: false |

### Association

- belongs_to :user