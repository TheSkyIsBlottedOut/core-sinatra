module SCore
  # Singleton methods
  class << self
    attr_reader :env
    def const_missing(sym)
      const_filename = sym.to_s.snake_case
      filename = File.join(self.root + "/etc/lib/#{const_filename}.rb")
      raise "Module #{sym} could not be found at #{filename}!" unless File.exists?(filename)
      class_eval(IO.read(filename))
      raise "Library file does not define constant #{sym} in #{filename}" unless const_defined?(sym)
      const_get(sym)
    end
    
    def dir(path)
      Dir[File.join(self.root, path)]
    end
    
    def load_framework
      self.dir('/etc/middleware/**/*.rb').each {|x| require x}
    end
    
    def gem_environment
      case @env.environment
      when /dev/ then 'development'
      when /prod/ then 'production'
      else
        'development'
      end
    end
    
    def start(args)
      @env = Hashie::Mash.new(args)
      self.dir('/etc/extensions/*.rb').each {|x| require x}
    end
    
    def environment
      @env.environment || self.gem_environment
    end
    
    def env?(arg)
      self.environment == arg.to_s
    end
    
    def file(path)
      File.join(self.root, path)
    end
    
    def root
      @env.root_path ||= File.expand_path(File.dirname(__FILE__) + '/..')
    end
  end
end