
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'site_prism'
require_relative 'page_helper.rb'
World(Pages)


Capybara.configure do |config|
  # ----Executar Firefox-----
  # config.default_driver = :selenium

  # ----Executar Chrome-----
  config.default_driver = :selenium_chrome
  # config.app_host = 'http://172.100.11.186/'
  config.app_host = 'http://irandubaadmin.northcentralus.cloudapp.azure.com/'
end

Capybara.default_max_wait_time = 10.to_i