# Esta classe representa a tela Cadastro de Produto
class PesquisarProduto < SitePrism::Page
  set_url '/product-list'

  element :campo_nome, 'input[name="name"]'
  element :campo_codigo, 'input[name="productCod"]'
  element :botao_pesquisar, '.fa-search'
  element :table_produto, 'table tbody tr'
  elements :table_prod, 'table tbody tr'
  element :mensagem, '.box-body h4 strong'

  def pesquisar_produto(produto)
    @produto = produto
    campo_nome.set @produto
    botao_pesquisar.click
    table_prod.size
  end

  def item_nao_encontrado(produto)
    @produto = produto
    campo_nome.set @produto
    botao_pesquisar.click
    mensagem
  end

  def pesquisa_por_codigo(produto)
    @produto = produto
    campo_codigo.set @produto
    botao_pesquisar.click
    table_produto.find('tr td:nth-child(1)').text
  end
  end
