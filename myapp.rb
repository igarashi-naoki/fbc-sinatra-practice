# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative './memo'

set :default_content_type, 'text/html;charset=utf-8'

['/', '/index', '/memos'].each do |route|
  get route  do
    @memos = {}
    Memo.read_all.each do |row|
      @memos[row['id']] = Memo.new(title: row['title'], body: row['body'])
    end
    erb :index
  end
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  Memo.create(title: params[:title], body: params[:body])
  redirect '/memos'
end

get '/memos/:id' do
  rows = Memo.read(id: params[:id])
  redirect not_found if rows.num_tuples.zero?
  @memo = Memo.new(title: rows[0]['title'], body: rows[0]['body'])
  erb :show
end

get '/memos/:id/edit' do
  rows = Memo.read(id: params[:id])
  redirect not_found if rows.num_tuples.zero?
  @memo = Memo.new(title: rows[0]['title'], body: rows[0]['body'])
  erb :edit
end

patch '/memos/:id' do
  Memo.update(id: params[:id], title: params[:title], body: params[:body])
  redirect '/memos'
end

delete '/memos/:id' do
  Memo.delete(id: params[:id])
  redirect '/memos'
end

not_found do
  erb :not_found
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

configure do
  Memo.connect_db
end
