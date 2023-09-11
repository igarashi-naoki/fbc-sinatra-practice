# frozen_string_literal: true

require 'json'
require 'pg'

DATA_FILE = 'memo_data.json'

# メモに関するデータをやりとりするクラスです
class Memo
  attr_reader :title, :body

  @db_connect = nil

  class << self
    def create(title:, body:)
      @db_connect.exec_params('INSERT INTO memos(title,body) values($1,$2);', [title, body])
    end

    def read(id:)
      @db_connect.exec_params('SELECT * FROM memos WHERE id = $1;', [id])
    end

    def update(id:, title:, body:)
      @db_connect.exec_params('UPDATE memos SET title = $2, body = $3 WHERE id = $1;', [id, title, body])
    end

    def delete(id:)
      @db_connect.exec_params('DELETE FROM memos WHERE id = $1;', [id])
    end

    def connect_db
      @db_connect = PG.connect(dbname: 'memo_app')
    end

    def read_all
      @db_connect.exec('SELECT * FROM memos ORDER BY created_at DESC;')
    end
  end

  def initialize(title:, body:)
    @title = title
    @body = body
  end
end
