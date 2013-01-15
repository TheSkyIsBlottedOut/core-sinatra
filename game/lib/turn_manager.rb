class Game::TurnManager
  Phases = [:events, :warmaking, :disband, :production, :tech_market, :build, :worker_placement, :military_placement, :military_actions]



  def self.setup(gamedata)
    gamedata.turn = Hashie::Mash.new(
      number:   0,
      phase:    :worker_placement,
      action:   nil     # i.e. what subpage is currently being displayed
    )
  end
end