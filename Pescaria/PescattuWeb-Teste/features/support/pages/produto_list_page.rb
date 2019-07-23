# ProdutoListPage é a classe que representa a tela de Lista de Produtos
class ProdutoListPage < SitePrism::Page
  set_url '/product-new'

    element :alerta_messagem, '#message'
    element :alerta_error, '#message.alert-error'
    element :campo_obrigatorio, '.help-block'
  end
