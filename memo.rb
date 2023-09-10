# frozen_string_literal: true

require 'json'
require 'pg'

DATA_FILE = 'memo_data.json'

# メモに関するデータをやりとりするクラスです
class Memo
  attr_reader :title, :body

  @db_connect = nil

  class << self
    def create(memo_id:, title:, body:)
      @db_connect.exec("INSERT INTO memos(memo_id,title,body) values('#{memo_id}','#{title}','#{body}');")
    end

    def read(memo_id:)
      @db_connect.exec("SELECT * FROM memos WHERE memo_id = '#{memo_id}';")
    end

    def update(memo_id:, title:, body:)
      @db_connect.exec("UPDATE memos SET title = '#{title}', body = '#{body}' WHERE memo_id = '#{memo_id}';")
    end

    def delete(memo_id:)
      @db_connect.exec("DELETE FROM memos WHERE memo_id = '#{memo_id}';")
    end

    def connect_db
      @db_connect = PG.connect(dbname: 'memo_app')
    end

    def read_all
      @db_connect.exec('SELECT * FROM memos')
    end
  end

  def initialize(title:, body:)
    @title = title
    @body = body
  end
end
