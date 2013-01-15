module AppLoader
  def run_initializers
    Dir[SCore.root + '/etc/init/*.rb'].each {|x| class_eval(IO.read(x)) }
  end

  def self.default_paths
    {
      routes:       { directory: '/routes',       type: 'directory',  method: :reload_application_routes },
      helpers:      { directory: '/helpers',      type: 'directory',  method: :reload_class_extensions },
      models:       { directory: '/models',       type: 'file',       method: :reload_application_model, load_on_init: false },
    }
  end

  def load_and_persist_application
    define_singleton_method :load_and_persist_application, lambda { false }
    load_all_application_files
    return unless SCore.gem_environment == 'development'
    # TODO: Ensure threadsafe. Priority: meh, this only runs in dev mode
    Thread.new do
      persistence_paths = SCore::AppLoader.default_paths.clone
      loop do
        sleep 5
        persistence_paths.each_pair do |key, args|
          case args[:type]
          when 'directory'
            if dir_updated_since?(args[:directory], args[:updated])
              self.send(args[:method], args[:directory])
            end
          when 'file'
            SCore.dir(args[:directory] + '/**/*.rb').each do |filename|
              if file_updated_since?(filename, args[:updated])
                self.send(args[:method], filename)
              end
            end
          end
          args[:updated] = Time.now
        end
      end
    end
  end

  def load_all_application_files
    SCore::AppLoader.default_paths.each_pair {|*,a| self.send(a[:method], a[:directory]) unless a[:load_on_init] == false }
  end

  def dir_updated_since?(path, time)
    return false unless time
    SCore.dir("#{path}/**/*.rb").inject(time) {|s,i| [s, File.mtime(i)].max } > time
  end

  def file_updated_since?(path, time)
    return false unless time
    File.exist?(path) && File.mtime(path) > time
  end

  def reload_application_model(file)
    # un-snake-case
    new_const = file.match(/\/(\w+)\.rb/)[1].camelcase.intern
    ::DB.reload!(new_const)
  end

  def reload_application_routes(path)
    @routes = {}
    self.reload_class_extensions(path)
  end

  def reload_class_extensions(path)
    SCore.dir("#{path}/**/*.rb").each {|x| class_eval(IO.read(x)) }
  end
end