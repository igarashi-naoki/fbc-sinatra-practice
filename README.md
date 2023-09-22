# fbc-sinatra-practice

ローカルでアプリケーションを立ち上げるための手順書です。

## データベースの初期設定
1. 各自の環境でpostgresをインストールし、起動します。


2. 現在のユーザーでログインし、「memo_app」データベースを作成します。

```shell
psql -U 現在のユーザ名 postgres
```
```sql
postgres=# create database memo_app;
```


## アプリの立ち上げ



1. 本リポジトリを任意のディレクトリにcloneします。

```shell
git clone git@github.com:igarashi-naoki/fbc-sinatra-practice.git
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
