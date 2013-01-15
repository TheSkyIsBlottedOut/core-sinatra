helpers do
  def load_game
    retval = SCore::Game.new(session[:game])
    session[:game] = retval.data
    retval
  end
end