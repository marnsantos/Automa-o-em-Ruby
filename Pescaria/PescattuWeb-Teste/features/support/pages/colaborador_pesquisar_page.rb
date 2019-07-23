# Esta classe representa a tela Pesquisar Colaborador
class ColaboradorPesquisar < SitePrism::Page
  set_url '/employee-list'

  element :campo_registro, 'input[name="registry"]'
  element :campo_nome, 'input[name="name"]'
  element :botao_pesquisar, '#search'
  elements :table_colab, 'tbody tr'
  element :table_colaborador, 'div.box-body tbody'
  element :mensagem, 'div.box-body strong'

  def pesquisar_colaborador(colaborador)
    @colaborador = colaborador
    campo_nome.set @colaborador
    botao_pesquisar.click
    Capybara.default_max_wait_time = 3.to_i
    table_colab.size
  end

  def item_n_encontrado(colaborador)
    @colaborador = colaborador
    campo_nome.set @colaborador
    botao_pesquisar.click
    mensagem
  end

  def pesquisar_colaborador_codigo(colaborador)
    @colaborador = colaborador
    campo_registro.set @colaborador
    botao_pesquisar.click
    table_colaborador.find('tr td:nth-child(3)').text
  end
end
