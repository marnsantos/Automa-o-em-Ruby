require 'appium_lib'

caps_path = File.join(File.dirname('_FILE_'), 'appium.txt')
caps = Appium.load_appium_txt file: caps_path, verbose: true

Appium::Driver.new(caps, true)
$driver.start_driver

$driver.remove_app 'com.pescato.itbam.pescattu2'

class AppiumWorld
end
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

Before { $driver.launch_app }

After { $driver.driver_quit }

# /Users/itbamamazonia/dev/Automatizar/Pescattu-Android/script
