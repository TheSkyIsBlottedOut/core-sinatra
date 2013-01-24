helpers do
  def load_game
    retval = Application::Game.new(session[:game])
    session[:game] = retval.data
    retval
  end
end