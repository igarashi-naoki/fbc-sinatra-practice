# frozen_string_literal: true

require 'json'

DATA_FILE = 'memo_data.json'

# メモに関するデータをやりとりするクラスです
class Memo
  attr_reader :id, :title, :body

  @memos = {}
  class << self
    attr_reader :memos

    def read
      File.new(DATA_FILE, 'w') unless File.exist?(DATA_FILE)

      JSON.parse(File.open(DATA_FILE).read, symbolize_names: true).each do |id, v|
        Memo.new(**v, id: id)
      end
    rescue JSON::ParserError
      nil
    end

    # memoのidの最大値+1を次に付与するIDとする
    def next_id
      @memos.keys.max_by(&:to_i).to_i + 1
    end

    def save
      save_json = @memos.transform_values(&:to_hash)
      File.write(DATA_FILE, JSON.pretty_generate(save_json), mode: 'w')
    end
  end

  def initialize(title:, body:, id: nil)
    @title = title
    @body = body
    memo_id = self.class.next_id
    memo_id = id unless id.nil? # データから
    Memo.instance_variable_get(:@memos)[memo_id.to_s] = self
  end

  def update(title:, body:)
    @title = title
    @body = body
  end

  def to_hash
    instance_variables.map do |instance_var|
      [instance_var.to_s.delete('@'), instance_variable_get(instance_var)]
    end.to_h
  end
end
