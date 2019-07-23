# ReceitaList é a classe que representa a tela de Lista de Receitas
class ReceitaList < SitePrism::Page
  set_url '/recipe-list'

  element :alerta_messagem, '#message'
  element :alerta_error, '#message.alert-error'
  element :campo_obrigatorio, 'span.help-block'
end
