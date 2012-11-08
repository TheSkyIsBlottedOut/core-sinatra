require 'fileutils'
namespace :assets do
  
  desc 'Clean'
  task :clean do
    FileUtils.rm_rf(SCore.file(SCore::Config.settings.assets.manifest))
  end
  
  desc 'Precompile assets'
  task :precompile do
    manifest = {}
    asset_path = SCore.file(SCore::Config.settings.assets.manifest)
    FileUtils.mkdir_p(asset_path)
    Application.sprockets.each_logical_path do |path|
      if asset = Application.sprockets.find_asset(path)
        filename = asset_path + "/#{Application.sprockets.digest}-#{path}"
        asset.write_to(filename)
        asset.write_to("#{filename}.gz") if filename.to_s =~ /(css|js)/
        manifest[path] = filename
      end
    end
    IO.write("#{asset_path}/manifest.yml", YAML.dump(manifest))
  end
end