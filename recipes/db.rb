include_recipe 'phpstack::mysql_base'

mysql_database 'drupal'  do
  connection(
    host: 'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  )
  action :create
end

mysql_database_user 'drupaluser' do
  connection(
    host: 'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  )

  password node['drupal']['db_password']
  database_name 'drupal'
  privileges [:select, :update, :insert, :drop]
  action :grant
end

db = "#{Chef::Config[:file_cache_path]}/drupal.sql"

remote_file db do
  source node['drupal']['db_source']
  action :create_if_missing
  notifies :run, 'execute[import]', :immediately
end

execute 'import' do
  command "mysql -u root --password=#{node['mysql']['server_root_password']} drupal <#{db}"
  action :nothing
end
