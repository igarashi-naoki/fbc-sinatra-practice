# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require_relative './memo'

set :default_content_type, 'text/html;charset=utf-8'

['/', '/index', '/memos'].each do |route|
  get route  do
    @memos = Memo.load_all
    erb :index
  end
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memos = Memo.load_all
  memos[SecureRandom.uuid.to_sym] = Memo.new(title: params[:title], body: params[:body])
  Memo.save(memos)
  redirect '/memos'
end

get '/memos/:id' do
  @memo = Memo.load_all[params[:id].to_sym]
  erb :show
end

get '/memos/:id/edit' do
  @memo = Memo.load_all[params[:id].to_sym]
  erb :edit
end

patch '/memos/:id' do
  memos = Memo.load_all
  memos[params[:id].to_sym].update(title: params[:title], body: params[:body])
  Memo.save(memos)
  redirect '/memos'
end

delete '/memos/:id' do
  memos = Memo.load_all
  memos.delete(params[:id].to_sym)
  Memo.save(memos)
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
