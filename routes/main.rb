get ?/ do
  erb :index
end

get '/game' do
  @game = load_game
  erb :game
end