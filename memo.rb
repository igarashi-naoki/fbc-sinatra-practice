# frozen_string_literal: true

require 'pg'

TABLE_NAME = 'memos'

# メモに関するデータをやりとりするクラスです
class Memo
  attr_reader :title, :body

  @db_connection = nil

  class << self
    def create(title:, body:)
      @db_connection.exec_params("INSERT INTO #{TABLE_NAME}(title,body) values($1,$2);", [title, body])
    end

    def read(id:)
      row = @db_connection.exec_params("SELECT * FROM #{TABLE_NAME} WHERE id = $1 LIMIT 1;", [id])
      return nil if row.count.zero?

      Memo.new(title: row[0]['title'], body: row[0]['body'])
    end

    def update(id:, title:, body:)
      @db_connection.exec_params("UPDATE #{TABLE_NAME} SET title = $2, body = $3 WHERE id = $1;", [id, title, body])
    end

    def delete(id:)
      @db_connection.exec_params("DELETE FROM #{TABLE_NAME} WHERE id = $1;", [id])
    end

    def connect_db
      @db_connection = PG.connect(dbname: 'memo_app')

      # memosテーブルが存在しなければ自動で作成する
      @db_connection.exec("SELECT 1 FROM #{TABLE_NAME} LIMIT 1;")
    rescue PG::UndefinedTable
      @db_connection.exec("CREATE TABLE #{TABLE_NAME}(
        id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
        title VARCHAR(200) NOT NULL,
        body TEXT NOT NULL,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
      );")
    end

    def read_all
      rows = @db_connection.exec("SELECT * FROM #{TABLE_NAME} ORDER BY created_at DESC;")
      rows.each_with_object({}) do |row, memos|
        memos[row['id']] = Memo.new(title: row['title'], body: row['body'])
      end
    end
  end

  def initialize(title:, body:)
    @title = title
    @body = body
  end
end
