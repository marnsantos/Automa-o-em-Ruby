Dado('que altero a seguinte receita {string}') do |receita|
  @receita = receita
  receita_editar_page.load
  @resultado = receita_editar_page.pesquisar(receita)
end

Dado('que faço alteração para {string}, {string}, {string}, {string}') do |nome, tempo, qtdpessoas, descricao|
  receita_editar_page.alterar_receita(@resultado, nome, tempo, qtdpessoas, descricao)
end

Dado('adicionando os seguintes ingredientes {string}') do |ingrediente|
  receita_editar_page.add_ingredientes(ingrediente)
end

Quando('informo os respectivos passos {string}') do |passo|
  receita_editar_page.add_passos(passo)
end

Entao('deve apresentar a mensagem {string}') do |mensagem_sucesso|
  receita_editar_page.salvar
  expect(receita_list_page.alerta_messagem.find('strong').text).to eql mensagem_sucesso
end

Quando('submeto campos em branco na alteração de receita {string}, {string}, {string}, {string}') do |nome, tempo, qtdpessoas, descricao|
  receita_editar_page.alterar_receita(@resultado, nome, tempo, qtdpessoas, descricao)
end

Entao('deve apresentar alerta de campo obrigatório {string}') do |mensagem_alerta|
  receita_editar_page.salvar 
  expect(receita_editar_page.campo_obrigatorio.text).to eql mensagem_alerta
end

Dado('que faço alteração da seguinte receita {string}, {string}, {string}, {string}') do |nome, tempo, qtdpessoas, descricao|
  receita_editar_page.alterar_receita(nome, tempo, qtdpessoas, descricao)
end

Quando('adiciono o ingrediente e passo {string}, {string}') do |ingrediente, passo|
  receita_editar_page.add_ingredientes_passos(ingrediente, passo)
  receita_editar_page.salvar
end

Entao('deve apresentar um alerta de erro {string}') do |alerta_err|
  expect(receita_list_page.alerta_error.text).to have_content alerta_err
end
