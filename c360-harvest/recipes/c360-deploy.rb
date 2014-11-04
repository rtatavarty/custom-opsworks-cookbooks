#app_root = "#{deploy[:deploy_to]}/current"
#node[:deploy].each do |application, deploy|
#  execute "mkdir #{app_root}" do
#  execute "chmod -R g+rw #{app_root}" do
#  end
#end
#
#git "#{deploy[:deploy_to]}/current" do
#  repository "git://github.com/opscode/chef.git"
#  reference "master"
#  action :sync
#end
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

end

log "c360 app deployed"
