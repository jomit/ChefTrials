# Create marketplace BYOL VM for chef and Setup Organization
# ======================================================================================================
tailf /var/log/cloud-init-output.log

sudo rm /var/opt/opscode/nginx/etc/nginx.d/analytics.conf

echo 'api_fqdn "jomitchefsrv.westus.cloudapp.azure.com"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

echo 'analytics_fqdn "jomitchefsrv.westus.cloudapp.azure.com"' | sudo tee -a /etc/opscode-analytics/opscode-analytics.rb

sudo chef-marketplace-ctl hostname jomitchefsrv.westus.cloudapp.azure.com

sudo opscode-analytics-ctl reconfigure

#- Browse https://jomitchefsrv.westus.cloudapp.azure.com/signup
#- Signup and Create new Organization
#- Login https://jomitchefsrv.westus.cloudapp.azure.com/organizations/jack/nodes  (jomit / pass@word1)
#- Download the starter kit


# Install and Setup Chef Development Kit
# ======================================================================================================
#- Go into chef-repo folder
#- Change the chef-repo\.chef\knife.rb file (chef_server_url)

knife ssl fetch

knife client list


# Install Chef extension from portal on the VM and run following commands
# ======================================================================================================

sudo chef-client -l debug

sudo tail -f /var/log/azure/Chef.Bootstrap.WindowsAzure.LinuxChefClient/1210.12.106.1000/chef-client.log


# Create VM with Chef extension using arm template (c:\github\ChefTrials\cheftrials)
# ======================================================================================================

azure login

azure account set 

azure config mode arm

azure group template validate -f "azuredeploy.json" -e "azuredeploy.parameters.json" -g ChefTrials

azure group deployment create -f "azuredeploy.json" -e "azuredeploy.parameters.json" -g ChefTrials -n CreateChefClientVM2



# Generate sample cookbooks and upload to chef server
# ==================================================================

chef generate repo test-repo

cd C:\github\ChefTrials\test-repo\cookbooks

chef generate cookbook helloworld   # or knife cookbook create helloworld

cd C:\github\ChefTrials\test-repo\cookbooks\helloworld\recipes

# - Change the content of the default.rb file as below:
# file '/tmp/chefmessage' do
#   content 'hello from linux !!'
# end

# file 'c:\chefmessage' do
#   content 'hello from windows !!'
# end

chef-client --local-mode default.rb   

# - Copy .chef folder from chef-repo into the helloworld folder

cd C:\github\ChefTrials\test-repo

knife cookbook upload helloworld


# - Edit the Run List for the node from the Management Portal : https://jomitchefsrv.westus.cloudapp.azure.com/organizations/jack/nodes/jomitnode1
# - Add the "helloworld" cookbook in the run list
# - Login to the node

sudo chef-client   # to apply the policies manually



# Generate Service Principle and assign Contribute role for Subscription
# ==========================================================================

azure account show
#> note the subscription id

azure ad sp create -n <sp-name> -p <password>

#> note the Object Id

azure role assignment create --objectId  <object id> -o Contributor -c /subscriptions/<subscription id>/





