Dado('que possuo a empresa {string}') do |empresa|
  @empresa = empresa
  empresa_editar_page.load
  @resultado = empresa_editar_page.pesquisar(empresa)
end

Quando('edito esta empresa {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento|
  empresa_editar_page.alterar_empresa(@resultado, cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento)
end

Quando('submeto campos em branco no cadastro de empresas {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento|
  empresa_editar_page.alterar_empresa(@resultado, cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento)
end

Entao('devo ver {string}') do |mensagem|
  expect(empresa_list_page.alerta_messagem.text).to have_content mensagem
end

Entao("exibe alerta {string}") do |alerta|
  expect(empresa_list_page.campo_obrigatorio.text).to eql alerta
end