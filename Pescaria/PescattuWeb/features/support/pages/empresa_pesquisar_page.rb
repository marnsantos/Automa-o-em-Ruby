# Esta classe representa a tela Pesquisar Empresa
class EmpresaPesquisar < SitePrism::Page
  set_url '/company-list'

  element :campo_cnpj, 'input[name="cnpj"]'
  element :campo_nome, 'input[name="razao-social"]'
  element :botao_pesquisar, '#search'
  elements :table_emp, 'tbody tr'
  element :table_empresa, 'div.box-body tbody'
  element :mensagem, 'div.box-body strong'

  def pesquisar_empresa(empresa)
    @empresa = empresa
    campo_nome.set @empresa
    botao_pesquisar.click
    Capybara.default_max_wait_time = 3.to_i
    table_emp.size
  end

  def item_n_encontrado(empresa)
    @empresa = empresa
    campo_nome.set @empresa
    botao_pesquisar.click
    mensagem
  end

  def pesquisar_codigo(empresa)
    @empresa = empresa
    campo_cnpj.set @empresa
    botao_pesquisar.click
    table_empresa.find('tr td:nth-child(1)').text
  end
end
