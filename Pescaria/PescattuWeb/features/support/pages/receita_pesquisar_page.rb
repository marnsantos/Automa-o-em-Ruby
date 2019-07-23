# Esta classe representa a tela Pesquisar Receitas
class PesquisarReceita < SitePrism::Page
  set_url '/recipe-list'

  element :campo_nome, 'input[name="nomeReceita"]'
  element :botao_pesquisar, '.fa-search'
  elements :table_receita, 'table tbody tr'
  element :mensagem, '.box-body h4 strong'

  def pesquisar_receita(receita)
    @receita = receita
    campo_nome.set @receita
    botao_pesquisar.click
    table_receita.size
  end

  def item_nao_encontrado(receita)
    @receita = receita
    campo_nome.set @receita
    botao_pesquisar.click
    mensagem
  end
end
