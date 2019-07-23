Dado('que faço login com {string} e {string}') do |email, senha|
  login_page.load
  login_page.logar(email, senha)
end

Então('devo ver a logo {string}') do |logo_home|
  expect(login_page.logo_user.text).to have_content logo_home
end

# Então('devo ver a mensagem de alerta {string}') do |mensagem_alerta|
#   expect(@login_page.mensagem.text).to eql mensagem_alerta
# end

# Então('devo ver a mensagem de bloqueio {string}') do |mensagem_bloqueio|
#   expect(@login_page.mensagem_bloq.text).to eql mensagem_bloqueio
# end
