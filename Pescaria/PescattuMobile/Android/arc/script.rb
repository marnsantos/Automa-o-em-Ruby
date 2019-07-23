#!/usr/bin/env ruby
require 'appium_lib'

# 1- Ler as informacoes do caps file - Done
caps_path = File.join(File.dirname('_FILE_'), 'appium.txt')
caps = Appium.load_appium_txt file: caps_path, verbose: true

# 2- Criar a sessao - Done
Appium::Driver.new(caps, true)
$driver.start_driver

$driver.remove_app 'com.pescato.itbam.pescattu2'

$driver.launch_app

# Pesquisa de Produtos
# edit = $driver.find_element :id, 'menuSearch'
# edit.send_keys 'Pirarucu'
button = $driver.find_element :id, 'btn_next'
button.click


# 3- Incluir Dados para Nova Conta
# $driver.wait_true(timeout: 10) { $driver.exists { $driver.find_element :id, 'navigation_header_container'}}

button = $driver.find_element :accessibility_id, 'Open navigation drawer'
button.click

button = $driver.find_element :xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.support.v4.widget.DrawerLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.support.v7.widget.LinearLayoutCompat[2]/android.widget.CheckedTextView'
button.click

button = $driver.find_element :xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout[2]/android.widget.TextView[2]'
button.click

edit = $driver.find_element :id, 'fullname_edit_create'
edit.send_keys 'Maria Ivonete Duarte'

edit = $driver.find_element :id, 'CPF_edit_create'
edit.send_keys '75585600206'

edit = $driver.find_element :id, 'mail_edit_create'
edit.send_keys 'maria_ivonete@gmail.com'

edit = $driver.find_element :id, 'phone_edit_create'
edit.send_keys '92 99999999'

edit = $driver.find_element :id, 'password_edit_create'
edit.send_keys '123456'

edit = $driver.find_element :id, 'password_confirm_edit_create'
edit.send_keys '123456'

# $driver.back

button = $driver.find_element :id, 'btnConfirmar_conta'
button.click

# 4- Fechar a sessao - Done
$driver.driver_quit