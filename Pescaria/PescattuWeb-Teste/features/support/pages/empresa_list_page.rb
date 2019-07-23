# EmpresaListPage é a classe que representa a tela de lista de Empresas
class EmpresaListPage < SitePrism::Page
  set_url '/company-new'

  element :alerta_messagem, '#message'
  element :campo_obrigatorio, '.help-block'
  element :titulo_pesquisar, '.with-border h3.box-title'
end