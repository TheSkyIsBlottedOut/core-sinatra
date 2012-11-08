Mongoid.load!(File.join(SCore.root, '/etc/config/mongoid.yml'), SCore.environment)

# Why have a DB namespace?
# So we can do magic reloading without deleting constants in the global namespace.

module ::DB
  def self.const_missing(sym)
    models_path = SCore::AppLoader.default_paths[:models][:directory]
    filename = SCore.file(models_path + "/#{sym.to_s.snake_case}.rb")
    raise "Module #{sym} could not be found at #{filename}!" unless File.exists?(filename)
    class_eval(IO.read(filename))
    raise "Library file does not define constant #{sym} in #{filename}" unless const_defined?(sym)
    retval = const_get(sym)
    retval.class_exec do
      store_in collection: self.name.collectionize.sub(/^db_/, '')
    end
    retval
  end
  
  def self.reload!(sym)
    self.send(:remove_const, sym) if self.const_defined?(sym)
  end
end