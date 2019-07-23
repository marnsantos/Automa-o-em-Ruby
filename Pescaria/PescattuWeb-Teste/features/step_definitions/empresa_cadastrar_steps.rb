Dado('que cadastro a seguinte empresa {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento|
  empresa_cadastrar_page.load
  empresa_cadastrar_page.cadastrar_empresa(cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento)
end

Entao('exibir a mensagem {string}') do |mensagem_emp|
  expect(empresa_list_page.alerta_messagem.find('strong').text).to eql mensagem_emp
end

Dado('que submeto campos em branco no cadastro de empresas {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento|
  empresa_cadastrar_page.load
  empresa_cadastrar_page.cadastrar_empresa(cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento)
end

Entao('exibir o alerta {string}') do |alertar|
  expect(empresa_list_page.campo_obrigatorio.text).to eql alertar
end

Dado('que cadastro a empresa {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento|
  empresa_cadastrar_page.load
  empresa_cadastrar_page.cancelar_operacao(cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento)
end

Entao('cancelo a operação devo retornar para lista de empresas {string}') do |titulo|
  expect(empresa_list_page.titulo_pesquisar.text).to eql titulo
end
