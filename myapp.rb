# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative './memo'

at_exit do
  Memo.read
end

set :default_content_type, 'text/html;charset=shift-jis'

['/', '/index', '/memos'].each do |route|
  get route  do
    @memos = Memo.memos
    erb :index
  end
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  Memo.new(title: h(params[:title]), body: h(params[:body]))
  Memo.save
  redirect '/memos'
end

get '/memos/:id' do
  @memo = Memo.memos[params[:id]]
  erb :show
end

get '/memos/:id/edit' do
  @memo = Memo.memos[params[:id]]
  erb :edit
end

patch '/memos/:id' do
  Memo.memos[params[:id]].update(title: h(params[:title]), body: h(params[:body]))
  Memo.save
  redirect '/memos'
end

delete '/memos/:id' do
  Memo.memos.delete(params[:id])
  Memo.save
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
