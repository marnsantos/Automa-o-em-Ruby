# Esta classe representa a tela Alterar Empresas
class EmpresaAlterar < SitePrism::Page
  set_url '/company-list'

  element :campo_busca, 'input[name="razao-social"]'
  element :botao_pesquisar, 'button[type="button"] i'
  element :botao_editar, '#edit-employee'
  element :campo_cidade, 'button[type="button"]'
  element :campo_nome, '#company-name'
  element :campo_cnpj, '#company-cnpj'
  element :campo_url, '#company-url'
  element :campo_telefone, '#company-phone'
  element :campo_contato, '#company-contact'
  element :campo_rua, '#company-street'
  element :campo_numero, '#company-number'
  element :campo_bairro, '#company-borough'
  element :campo_cep, '#company-cep'
  element :campo_complemento, '#company-complement'
  element :botao_salvar, 'button.btn-primary'
  element :botao_cancelar, 'button.btn-default'

  def pesquisar(empresa)
    Capybara.default_max_wait_time = 3.to_i
    @empresa = empresa
    campo_busca.set @empresa
    botao_pesquisar.click
  end

  def alterar_empresa(empresa, cidade, nome, cnpj, url, telefone, contato, rua, numero, bairro, cep, complemento)
    Capybara.default_max_wait_time = 3.to_i
    @empresa = empresa
    botao_editar.click
    campo_cidade.find(:xpath, '//span[text()=' + "'" + cidade + "'" + ']').select_option
    # campo_cidade.set cidade
    campo_nome.set nome
    campo_cnpj.set cnpj
    campo_url.set url
    campo_telefone.set telefone
    campo_contato.set contato
    campo_rua.set rua
    campo_numero.set numero
    campo_bairro.set bairro
    campo_cep.set cep
    campo_complemento.set complemento
    botao_salvar.click
  end
end
