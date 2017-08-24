
default[:vault][:bin_dir] = '/usr/local/bin'
default[:vault][:version] = '0.8.1'
default[:vault][:zip_file] = "vault_#{node[:vault][:version]}_linux_amd64.zip"
default[:vault][:download_url] = "https://releases.hashicorp.com/vault/#{node[:vault][:version]}/#{node[:vault][:zip_file]}"
