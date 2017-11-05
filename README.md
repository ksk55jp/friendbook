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
# Sさんより教えてもらう
bundle install --path vendor/bundle
(include vendor/bundle into .gitignore and git rm -r vendor/bundle --cached to remove from staging area(SA hereafter))
```
#### 2-2. `.gitignore` 整備
- `.env`ファイル追加
#### 2-3. データベース作成
```bash
bundle exec rake db:create

# 以下 rails / rake 系のコマンドはこのようにbundle execをプレフィックスする。
# 面倒なので、alias をセット
alias rails="bundle exec rails"
alias rake="bundle exec rake"
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

### 3. Topic投稿機能を実装
#### コントローラー生成
rails g controller topic index
#### モデル生成
rails g model topic
#### テーブル定義編集
t.{データ型} <カラム名>
#### viewファイルの編集
controllerメソッドからインスタンス変数を準備
viewファイルでインスタンス変数を受け取る
form_for(@<インスタンス変数>) do |f| でformを記述

#### 3-1. バリデーション
modelにバリデーションを記述
validates, :title, presence: true
validates, :<カラム名>, <バリデート属性>: 値
confirm 画面で画面でバリデートするように変更
## 3-2. フラッシュメッセージ

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
### 9. デザイン
### 10. aws+Capistrano

## 進捗
- 20170918 : バリデーションをつけた。ビューをパーシャルでリファクタする
- 20170918 : コンファームビューをつけた。
- 20171001 : Login with email
- 20171101 : Picture model を作ってtopicとAssociateした






