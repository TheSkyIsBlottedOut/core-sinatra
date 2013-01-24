module Game::Building
  class << self
    def building(data = {})
      data = {
        name: 'Generic Building',
        description: 'This is a generic building',
        tooltip: 'This is just a generic building',
        population: {
          max: 5,
          current: 0
        }
      }.merge(data)
      Hashie::Mash.new(data)
    end
  end
end