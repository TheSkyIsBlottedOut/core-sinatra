get ?/ do
  flash.now[:notice] = 'hi'
  erb :index
end

get '/game' do
  @game = load_game
  erb :game
end