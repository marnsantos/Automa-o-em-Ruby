Dado('que faço o cadastro da seguinte receita {string}, {string}, {string}, {string}') do |nome, tempo, qtdpessoas, descricao|
  receita_cadastrar_page.load
  receita_cadastrar_page.cadastrar(nome, tempo, qtdpessoas, descricao)
end

Dado('adiciono os ingredientes {string}') do |ingrediente|
  receita_cadastrar_page.incluir_ingredientes(ingrediente)
end

Quando('informo os passos {string}') do |passo|
  receita_cadastrar_page.incluir_passos(passo)
end

Entao('deve exibir uma mensagem {string}') do |mensagem|
  receita_cadastrar_page.salvar
  expect(receita_list_page.alerta_messagem.find('strong').text).to eql mensagem
end

Dado('que submeto campos em branco no cadastro de receita {string}, {string}, {string}, {string}') do |nome, tempo, qtdpessoas, descricao|
  receita_cadastrar_page.load
  receita_cadastrar_page.cadastrar(nome, tempo, qtdpessoas, descricao)
end

Entao('deve exibir um alerta de campo obrigatório {string}') do |alertar|
  receita_cadastrar_page.salvar
  expect(receita_list_page.campo_obrigatorio.text).to eql alertar
end

Quando('incluo o ingrediente e passo {string}, {string}') do |ingrediente, passo|
  receita_cadastrar_page.add_ingredientes_passos(ingrediente, passo)
  receita_cadastrar_page.salvar
end

Entao('deve exibir um alerta de erro {string}') do |alertar_erro|
  receita_cadastrar_page.salvar
  expect(receita_list_page.alerta_error.text).to have_content alertar_erro
end


