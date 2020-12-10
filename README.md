# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association

- has_one :profile

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