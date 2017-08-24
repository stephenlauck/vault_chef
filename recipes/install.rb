package 'unzip' do
  action :install
end

zip_file = File.join(Chef::Config[:file_cache_path], node[:vault][:zip_file])
remote_file zip_file do
  source node[:vault][:download_url]
  notifies :run, 'execute[install vault]', :immediately
end

execute 'install vault' do
  cwd Chef::Config[:file_cache_path]
  command "unzip -o #{zip_file} -d #{node[:vault][:bin_dir]}"
  action :nothing
end

user 'vault'

group 'vault' do
  action :modify
  members 'vault'
  append true
end

file "#{node[:vault][:bin_dir]}/vault" do
  mode '0755'
  owner 'vault'
  group 'vault'
end

directory '/etc/vault.d' do
  mode '0755'
  owner 'vault'
  group 'vault'
end

template '/etc/vault.d/vault.hcl' do
  owner 'vault'
  group 'vault'
  mode '0644'
  notifies :reload, 'systemd_unit[vault.service]'
  notifies :restart, 'systemd_unit[vault.service]'
end

execute "Granting mlock syscall to vault binary" do
  command "setcap cap_ipc_lock=+ep #{node[:vault][:bin_dir]}/vault"
end

systemd_unit 'vault.service' do
  content <<-EOU.gsub(/^\s+/, '')
  [Unit]
  Description=Vault Agent
  Requires=network-online.target
  After=network-online.target

  [Service]
  Restart=on-failure
  ExecStart=/usr/local/bin/vault server -config /etc/vault.d
  ExecReload=/bin/kill -HUP $MAINPID
  KillSignal=SIGTERM
  User=vault
  Group=vault

  [Install]
  WantedBy=multi-user.target
  EOU

  action [:create, :enable, :start]
end

file '/etc/profile.d/vault.sh' do
  content 'export VAULT_ADDR=http://127.0.0.1:8200'
end
