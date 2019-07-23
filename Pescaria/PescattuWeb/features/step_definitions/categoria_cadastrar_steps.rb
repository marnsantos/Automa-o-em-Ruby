Dado('que faço o cadastro da categoria {string}') do |categoria|
  categoria_cadastrar_page.load
  categoria_cadastrar_page.cadastrar_categoria(categoria)
end

Entao('exibe uma mensagem {string}') do |mensagem|
  expect(categoria_cadastrar_page.suce_mensagem.find('strong').text).to eql mensagem
end

Dado('que submeto campos em branco no cadastro da categoria {string}') do |categoria|
  categoria_cadastrar_page.load
  categoria_cadastrar_page.cadastrar_categoria(categoria)
end

Entao('deve apresentar alerta {string}') do |mensagem_alerta|
  expect(categoria_cadastrar_page.campo_obrigatorio.text).to eql mensagem_alerta
end
