set :application, "InvestmentSimulator"
set :repository,  "git@github.com:rascov/InvestmentSimulator.git"

set :scm, :git

role :web, "altum.itsze.ro"
role :app, "altum.itsze.ro"
role :db,  "altum.itsze.ro", :primary => true 

set :user, 'invest'
set :deploy_to, '/home/invest/src'

after "deploy:update_code", "db:symlink"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  task :symlink do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  end
end
