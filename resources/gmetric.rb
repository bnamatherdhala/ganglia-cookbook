# inspired by https://github.com/heavywater/chef-ganglia
actions :enable, :disable

attribute :script_name, :kind_of => String, :name_attribute => true
attribute :options, :kind_of => Hash, :default => {}