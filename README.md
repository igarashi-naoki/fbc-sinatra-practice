# fbc-sinatra-practice

ローカルでアプリケーションを立ち上げるための手順書です。

1. 本リポジトリを任意のディレクトリにcloneします。

```shell
git clone git@github.com:igarashi-naoki/fbc-sinatra-practice.git
```
branch状況に応じて、以下オプションを用いてbranchを指定してください。
```shell
-b add_main_code
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