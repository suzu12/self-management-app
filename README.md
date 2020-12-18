Hello! NewMe
==

[![Image from Gyazo](https://i.gyazo.com/3104c25a587c484acdeb0c7e2e23cd13.gif)](https://gyazo.com/3104c25a587c484acdeb0c7e2e23cd13)

[![Image from Gyazo](https://i.gyazo.com/b0100db49256ed86241d696f3c4e5a41.gif)](https://gyazo.com/b0100db49256ed86241d696f3c4e5a41)

## 概要

挑戦したいことがある方、一人だとなかなか習慣化ができないという方、同じ目標を持つ仲間を見つけてチャレンジすることができます。
<br>[こちらからアプリのチェックをお願いします！](https://www.selfmanagers.net/)

## テストアカウント

メールアドレス | test123@example.com
-- | --
パスワード | test123

## 仕様

- macOS Catalina 10.15.7
- Ruby 2.6.6
- Ruby on Rails 6.0.3.4
- Nginx 1.19.0
- Puma 4.3.7
- Docker
- AWS
- MySQL 8.0
- Google API

## 要件定義

- ユーザー管理機能(devise)
- SNS認証(Google API)
- ウィザード形式の新規登録
- チーム機能
- タグ機能
- チャット機能
- プロフィール機能
- アカウント機能
- 検索機能
- いいね機能(Ajax)
- コメント機能(Ajax)
- フォロー機能

## 今後実装していきたいこと

- 通知機能
- フォロー機能、チャット機能のAjax（Vue.js）

## DB設計
![entity-relationship-diagram](https://user-images.githubusercontent.com/66364552/102299635-97d69980-3f96-11eb-9f96-13f87b3a5cac.png)


# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association

- has_one :profile
- has_one :nickname

- has_many :sns_credentials
- has_many :team_users
- has_many :teams, through: :team_users

- has_many :chats
- has_many :likes
- has_many :favorite_teams, through: :likes, source: :team

- has_many :following_relationships, class_name: 'Relationship', foreign_key: 'following_id'
- has_many :followings, through: :following_relationships, source: :follower

- has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
- has_many :followers, through: :follower_relationships, source: :following


## sns_credentials テーブル

| Column   | Type       | Options     |
| -------- | ---------- | ----------- |
| provider | string     | null: false |
| uid      | string     | null: false |
| user     | references | null: false |

### Association

- belongs_to :user, optional: true


## nicknames テーブル

| Column   | Type       | Options     |
| -------- | ---------- | ----------- |
| nickname | string     | null: false |
| user     | references |             |

- belongs_to :user, optional: true


## teams テーブル

| Column        | Type       | Options      |
| ------------- | -----------| ------------ |
| category_id   | integer    | null: false  |
| team_name     | string     | null: false  |
| introduction  | text       | null: false  |
| period_id     | integer    | null: false  |

### Association

-  has_many :team_users
-  has_many :users, through: :team_users

-  has_many :chats
-  has_many :likes
-  has_many :comments

-  has_many :team_tag_relations
-  has_many :tags, through: :team_tag_relations


## team_users テーブル

| Column  | Type       | Options            |
| ------- | ---------- | ------------------ |
| user    | references | foreign_key: true  |
| team    | references | foreign_key: true  |

### Association

- belongs_to :user
- belongs_to :team


## tags テーブル

| Column  | Type   | Options     |
| ------- | ------ | ----------- |
| name    | string | null: false |

### Association

- has_many :team_tag_relations
- has_many :teams, through: :team_tag_relations


## team_tag_relations テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ------------------|
| team    | references | foreign_key: true |
| tag     | references | foreign_key: true |

### Association

- belongs_to :team
- belongs_to :tag


## chats テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| content | string     | null: false       |
| user    | references | foreign_key: true |
| team    | references | foreign_key: true |

### Association

- has_one :nickname
- has_one :nickname, through: :user

- belongs_to :user
- belongs_to :team


## profiles テーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| bio      | text       | null: false       |
| birthday | date       | null: false       |
| gender   | integer    | null: false       |
| user     | references | foreign_key: true |

### Association

- belongs_to :user


## likes テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| team    | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :team


## comments テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| content | text       | null: false       |
| team    | references | foreign_key: true |

### Association

- belongs_to :team


## relationships テーブル

| Column    | Type       | Options                           |
| --------- | ---------- | --------------------------------- |
| following | references | foreign_key: { to_table: :users } |
| follower  | references | foreign_key: { to_table: :users } |

### Association

- belongs_to :following, class_name: 'User'
- belongs_to :follower,  class_name: 'User'
