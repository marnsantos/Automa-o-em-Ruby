Dado('que eu pesquiso a empresa: {string}') do |empresa|
  @empresa = empresa
  empresa_pesquisar_page.load
  @resultado = empresa_pesquisar_page.pesquisar_empresa(empresa)
end


Dado('que eu pesquiso a empresa por codigo: {string}') do |empresa|
  @empresa = empresa
  empresa_pesquisar_page.load
  @resultado_cod = empresa_pesquisar_page.pesquisar_codigo(empresa)
end

Dado("que pesquiso a empresa: {string}") do |empresa|
    @empresa = empresa
    empresa_pesquisar_page.load
    @mensagem_visualizada = empresa_pesquisar_page.item_n_encontrado(empresa)
  end

Entao('deve vir resultado da pesquisa {int} itens') do |qtd_empresa|
    expect(@resultado).to eql qtd_empresa
  end

Entao('deve exibir resultado da pesquisa {string}') do |resu_codigo|
  expect(@resultado_cod).to have_content resu_codigo
end

Entao('vejo o resultado da pesquisa') do |mensagem|
  expect(@mensagem_visualizada.text).to eql mensagem
end
