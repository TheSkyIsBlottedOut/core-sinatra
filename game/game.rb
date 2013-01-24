class Game
  attr_reader :data
  @@buildings = SCore.configuration('buildings')
  def initialize(tdata = nil)
    if tdata
      @data = Hashie::Mash.new(tdata)
    else
      @data = self.class.setup
    end
  end

  def self.setup
    data = Hashie::Mash.new(
      turn: TurnManager.default,
      territories: [Game::Territory.territory],
      buildings: buildings_named(:agriculture, :resources, :military)
    )
  end

  def self.buildings_named(*args)
    args.map!(&:to_s)
    @@buildings.select {|k,*| args.include?(k)}
  end
end