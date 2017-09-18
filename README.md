# 大課題３ Facebookクローン FriendBook


## Table of content
### 1. 開発環境
### 2. アプリケーションのワクを作る
#### 2-1. `rails new`
#### 2-2. `.gitignore` 整備
#### 2-3. データベース作成
#### 2-4. エラーハンドリング系
#### 2-5. 
### 3. Topic投稿機能を実装
#### 3-1. バリデーション
#### 3-2. フラッシュメッセージ
#### 3-3. シードデータ準備
### 4. ログイン機能 - メールアドレス編
### 5. ログイン機能 - SNS編
### 6. コメント機能
### 7. フォロー機能
### 8. 日本語化
### 9. デザイン
### 10. aws+Capistrano

--
### 1. 開発環境
- Mac OS
- Ruby 2.3.0
- Rails 4.2.3
1. github.comにてリポジトリを作成 リポジトリ名friendbook README.mdなし
2. sshのパスをクリップボードにコピー
3. ローカルにてgit push --set-upstream git@github.com:ksk55jp/friendbook.git master
4. README.mdを記述開始

### 2. アプリケーションのワクを作る
#### 2-1. `rails new`
```bash
cd ~/workspace/friendbook
rails _4.2.3_ new friendbook -d postgresql
# 斎藤さんより教えてもらう
bundle install --path vendor/bundle
(include vendor/bundle into .gitignore and git rm -r vendor/bundle --cached to remove from staging area(SA hereafter))
```
#### 2-2. `.gitignore` 整備
- `.env`ファイル追加
#### 2-3. データベース作成
```bash
bundle exec rake db:create
```

#### 2-4. エラーハンドリング系
- Gemfileを編集 以下2つのGemを追加
```
group :development, :test do
  ....
  gem 'pry-rails'
  gem 'better_errors'
end
```
bundle install を実行
``` bash
bundle install --path vendor/bundle
```

#### 2-5. 
### 3. Topic投稿機能を実装
``` bash
# コントローラー生成
rails g controller topic index
# モデル生成
rails g model topic
# テーブル定義編集
```bash
vim db/migrate/20170918011544_create_topics.rb
```
```ruby
t.text :title
t.string :content
```  
```bash
bundle exec rake db:migrate
```
- config/routes.rb編集
```ruby
  resources :topics, only: [:index, :new, :create]
```

- viewファイルの編集
```erb
<h1>トピック一覧</h1>
<% @topics.each do |topic|%>
  <p>タイトル:<%= topic.title %></p>
  <p>本文:<%= topic.content %></p>
  <p>投稿日<%= topic.created_at %></p>
  <p>最終編集日<%= topic.updated_at %></p>
<% end %>

<%= link_to "投稿する", new_topic_path %>
(app/views/topics/index.html.erb)
```

```erb
<%= form_for(@topic) do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <br>
  <%= f.label :content %>
  <%= f.text_field :content %>
  <br>
  <%= f.submit %>
<% end %>

<%= link_to "投稿一覧に戻る", topics_path %>
(app/views/topics/new.html.erb)
```



#### 3-1. バリデーション
#### 3-2. フラッシュメッセージ
#### 3-3. シードデータ準備
Gemfileに下記を追記
```
gem 'faker'
```
```bash
bundle install --path vendor/bundle
```
### 4. ログイン機能 - メールアドレス編
### 5. ログイン機能 - SNS編
### 6. コメント機能
### 7. フォロー機能
### 8. 日本語化
config/application.rb
```ruby
  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
  # bundle exec rake time:zone:all
  config.time_zone = 'Tokyo'   # タイムゾーンを修正する

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
  config.i18n.default_locale = :ja
```
### 9. デザイン
### 10. aws+Capistrano

