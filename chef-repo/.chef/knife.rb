# See https://docs.chef.io/azure_portal.html#azure-marketplace/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "jomit"
client_key               "#{current_dir}/jomit.pem"
validation_client_name   "jack-validator"
validation_key           "#{current_dir}/jack-validator.pem"
chef_server_url          "https://jomitchefsrv.westus.cloudapp.azure.com/organizations/jack"
cookbook_path            ["#{current_dir}/../cookbooks"]
