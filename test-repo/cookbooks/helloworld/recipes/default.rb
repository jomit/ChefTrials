#
# Cookbook Name:: helloworld
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#file 'C:\Users\jovagh\Desktop\chefmessage' do
file '/tmp/chefmessage' do
  content 'hello from mars!!'
  #action :delete
  #content node['helloworld']['message']
end