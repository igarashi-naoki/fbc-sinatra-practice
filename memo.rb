# frozen_string_literal: true

require 'json'

DATA_FILE = 'memo_data.json'

# メモに関するデータをやりとりするクラスです
class Memo
  attr_reader :title, :body

  class << self
    def load_all
      File.new(DATA_FILE, 'w') unless File.exist?(DATA_FILE)
      # jsonファイルから　{:id => Memoインスタンス, ..} のハッシュを返す
      JSON.parse(File.open(DATA_FILE).read, symbolize_names: true).transform_values { |v| Memo.new(**v) }
    rescue JSON::ParserError
      {}
    end

    def save(memos)
      save_json = memos.transform_values(&:to_hash)
      File.write(DATA_FILE, JSON.pretty_generate(save_json), mode: 'w')
    end
  end

  def initialize(title:, body:)
    @title = title
    @body = body
  end

  def update(title:, body:)
    @title = title
    @body = body
  end

  def to_hash
    { title: @title, body: @body }
  end
end
