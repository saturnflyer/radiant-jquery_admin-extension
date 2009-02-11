namespace :radiant do
  namespace :extensions do
    namespace :jquery_admin do
      
      desc "Runs the migration of the Jquery Admin extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          JqueryAdminExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          JqueryAdminExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Jquery Admin to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[JqueryAdminExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(JqueryAdminExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
