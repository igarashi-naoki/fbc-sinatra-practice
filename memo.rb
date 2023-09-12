# frozen_string_literal: true

require 'pg'

# メモに関するデータをやりとりするクラスです
class Memo
  attr_reader :title, :body

  @db_connect = nil
  @table_name = 'memos'

  class << self
    def create(title:, body:)
      @db_connect.exec_params("INSERT INTO #{@table_name}(title,body) values($1,$2);", [title, body])
    end

    def read(id:)
      @db_connect.exec_params("SELECT * FROM #{@table_name} WHERE id = $1;", [id])
    end

    def update(id:, title:, body:)
      @db_connect.exec_params("UPDATE #{@table_name} SET title = $2, body = $3 WHERE id = $1;", [id, title, body])
    end

    def delete(id:)
      @db_connect.exec_params("DELETE FROM #{@table_name} WHERE id = $1;", [id])
    end

    def connect_db
      @db_connect = PG.connect(dbname: 'memo_app')

      # memosテーブルが存在しなければ自動で作成する
      @db_connect.exec("SELECT 1 FROM #{@table_name} LIMIT 1;")
    rescue PG::UndefinedTable
      @db_connect.exec("CREATE TABLE #{@table_name}(
          id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
          title VARCHAR(200) NOT NULL,
          body TEXT NOT NULL,
          created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
        );")
    end

    def read_all
      @db_connect.exec("SELECT * FROM #{@table_name} ORDER BY created_at DESC;")
    end
  end

  def initialize(title:, body:)
    @title = title
    @body = body
  end
end
