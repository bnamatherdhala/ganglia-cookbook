case node[:platform]
when "ubuntu", "debian"
  package "ganglia-webfrontend"
when "redhat", "centos", "fedora"
  package "httpd"
  package "php"
  include_recipe "ganglia::source"
  include_recipe "ganglia::gmetad"

  execute "copy web directory" do
    command "cp -r web /var/www/html/ganglia"
    creates "/var/www/html/ganglia"
    cwd "/usr/src/ganglia-#{node[:ganglia][:version]}"
  end
end

directory "/etc/ganglia-webfrontend"

service "apache2" do
  service_name "httpd" if platform?( "redhat", "centos", "fedora" )
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

%w[cluster_legend node_legend].each do |filename|
  cookbook_file "/usr/share/ganglia-webfrontend/#{filename}.html" do
    cookbook "ganglia"
    source "#{filename}.html"
    owner "root"
    group "root"
    mode "0644"
  end
end

apache2_passwd "Ganglia user" do
  username node[:ganglia][:admin][:user]
  password node[:ganglia][:admin][:password]
  action :add
end
