
require 'cucumber'
require 'capybara/cucumber'
require 'site_prism'
require_relative 'page_helper.rb'
World(Pages)

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = 'http://172.100.10.137:4000'
end
Capybara.default_max_wait_time = 10.to_i
