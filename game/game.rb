class Game
  attr_reader :data

  def initialize(tdata = nil)
    if tdata
      @data = Hashie::Mash.new(tdata)
    else
      @data = self.class.setup
    end
  end




  def self.setup
    data = Hashie::Mash.new
    TurnManager.setup(data)
  end
end