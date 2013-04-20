apt_repository "ganglia" do
  uri "http://ppa.launchpad.net/rufustfirefly/ganglia/ubuntu"
  keyserver "keyserver.ubuntu.com"
  key "A93EFBE2"
  distribution node["lsb"]["codename"]
  components ["main"]
  notifies :run, "execute[apt-get update]", :immediately
end
