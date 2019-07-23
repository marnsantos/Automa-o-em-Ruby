Dado('que acesso o formulario de login') do
  button = $driver.find_element :accessibility_id, 'Open navigation drawer'
  button.click
  button = $driver.find_element :xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.support.v4.widget.DrawerLayout/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.support.v7.widget.LinearLayoutCompat[2]/android.widget.CheckedTextView'
  button.click
end
Quando('faço login com {string} e {string}') do |cpf, senha|
  cpf = $driver.find_element :id, 'UserEdit'
  cpf.send_key '75585600206'
  senha = $driver.find_element :id, 'passwordEdit'
  senha.send_key '123456'

  button = $driver.find_element :id, 'btnConfirmar'
  button.click

  button = $driver.find_element :accessibility_id, 'Open navigation drawer'
  button.click
end

Então('devo ser autenticado e ver Ofertas e Produtos') do
end
