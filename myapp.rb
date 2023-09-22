# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative './memo'

set :default_content_type, 'text/html;charset=utf-8'

['/', '/index', '/memos'].each do |route|
  get route  do
    @memos = Memo.read_all
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
  @memo = Memo.read(id: params[:id])
  redirect not_found if @memo.nil?
  erb :show
end

get '/memos/:id/edit' do
  @memo = Memo.read(id: params[:id])
  redirect not_found if @memo.nil?
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
