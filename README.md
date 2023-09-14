# fbc-sinatra-practice

ローカルでアプリケーションを立ち上げるための手順書です。

## データベースの初期設定
1. Homebrewを使用してPostgreSQLをインストールします。

```shell
brew install postgresql
```

2. PostgreSQLを起動します。

```shell
brew services start postgresql
```

3. Macユーザーでログインし、データベースを作成します。

```shell
psql -U macのユーザ名 postgres
```
```sql
postgres=# create database memo_app;
```



## アプリの立ち上げ



1. 本リポジトリを任意のディレクトリにcloneします。

```shell
git clone git@github.com:igarashi-naoki/fbc-sinatra-practice.git
```
branch状況に応じて、以下オプションを用いてbranchを指定してください。
```shell
-b add_main_code
-b add_database_connection
```

2. cloneしたディレクトリ内に移動します。
```shell
cd fbc-sinatra-practice
```

3.  必要なgemをインストールします。
```shell
bundle install
```


4.  アプリケーションを立ち上げます。
```shell
bundle exec ruby myapp.rb
```
