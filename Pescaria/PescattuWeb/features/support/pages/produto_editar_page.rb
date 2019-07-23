# AlterarProdutoPage representa a tela de alteração de produto
class AlterarProdutoPage < SitePrism::Page
  set_url '/product-list'

  element :campo_busca, 'input[name="productCod"]'
  element :botao_pesquisar, 'button[type="button"] i'
  element :botao_editar, 'table tbody tr:nth-child(1) td:nth-child(6)'
  element :campo_nome, '#product-name'
  element :campo_codigo, '#product-code'
  element :campo_tamanho, '#product-size'
  element :campo_peso, '#product-weight'
  element :campo_descricao, '#product-description'
  element :campo_proteina, '#product-protein'
  element :campo_gordura, '#product-total-fat'
  element :campo_valor_energetico, '#product-energetic-value'
  element :campo_freezer, '#product-freezer'
  element :campo_geladeira, '#product-refrigerator'
  element :campo_preco_aplicativo, '#product-price-app'
  element :campo_preco_varejo, '#product-price'
  element :campo_preco_embalagem, '#product-packing'
  element :campo_preco_licenca, '#product-license'
  element :botao_salvar, 'button.btn-primary'
  element :campo_obrigatorio, '.help-block'
  element :alerta_messagem, '#message'
  element :alerta_error, '.alert-error strong'

  def pesquisar(produto)
    Capybara.default_max_wait_time = 3.to_i
    @produto = produto
    campo_busca.set @produto
    botao_pesquisar.click
  end

  def alterar_produto(produto, nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca)
    Capybara.default_max_wait_time = 3.to_i
    @produto = produto
    botao_editar.click
    campo_nome.set nome
    campo_codigo.set codigo
    campo_tamanho.set tamanho
    campo_peso.set peso
    campo_descricao.set descricao
    campo_proteina.set proteina
    campo_gordura.set gordura
    campo_valor_energetico.set energetico
    campo_freezer.set freezer
    campo_geladeira.set geladeira
    campo_preco_aplicativo.set preco_aplicativo
    campo_preco_varejo.set preco_varejo
    campo_preco_embalagem.set preco_embalagem
    campo_preco_licenca.set preco_licenca
    botao_salvar.click
  end
  end
