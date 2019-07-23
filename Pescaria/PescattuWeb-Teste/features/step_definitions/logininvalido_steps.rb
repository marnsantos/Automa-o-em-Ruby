Dado('que tento realizar login com {string} e {string}') do |email, senha|
  logininvalido_page.load
  logininvalido_page.tentarlogar(email, senha)
end

Então('deve exibir mensagem {string}') do |mensagem_alerta|
  expect(logininvalido_page.mensagem.find(:xpath, 'strong').text).to have_content mensagem_alerta
end