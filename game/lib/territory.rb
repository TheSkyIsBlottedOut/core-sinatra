module Game::Territory
  class << self
    def default


    end


    def territory(data = {})
      Hashie::Mash.new(
        name: data[:name] || 'Generic Territory',
        population: data[:population] || 6,
        capabilities: data[:capabilities] || {}
      )
    end
  end
end