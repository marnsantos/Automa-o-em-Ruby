#  ReceitaEditar representa a tela de alteração de receita
class ReceitaEditar < SitePrism::Page
  set_url '/recipe-list'

  element :campo_busca, 'input[name="nomeReceita"]'
  element :botao_pesquisar, 'button[type="button"] i'
  element :botao_editar, 'table tbody tr:nth-child(1) td:nth-child(4)'
  element :campo_nome, '#recipe-name'
  element :campo_tempo, '#recipe-time'
  element :campo_qtdpessoas, '#recipe-amount-people'
  element :campo_descricao, '#recipe-description'
  element :bt_add_ingrediente, '#add-ingredient'
  element :campo_ingrediente, '#recipe-ingredient'
  element :bt_add_passo, '#add-step'
  element :campo_passos, '#recipe-description-step'

  element :botao_salvar, 'button.btn-primary'
  element :campo_obrigatorio, 'span.help-block'

  def pesquisar(receita)
    Capybara.default_max_wait_time = 3.to_i
    @receita = receita
    campo_busca.set @receita
    botao_pesquisar.click
  end

  def alterar_receita(receita, nome, tempo, qtdpessoas, descricao)
    Capybara.default_max_wait_time = 3.to_i
    # @receita = receita
    botao_editar.click
    campo_nome.native.clear
    campo_nome.click
    campo_nome.set ' '
    campo_tempo.set tempo
    campo_qtdpessoas.set qtdpessoas
    campo_descricao.set descricao
    sleep 5
  end

  def add_ingredientes(ingrediente)
    campo_ingrediente.set ingrediente
    bt_add_ingrediente.click
    Capybara.default_max_wait_time = 3.to_i
  end

  def add_passos(passo)
    campo_passos.set passo
    bt_add_passo.click
    Capybara.default_max_wait_time = 3.to_i
  end

  def salvar()
    botao_salvar.click
  end

  def add_ingredientes_passos(ingrediente, passo)
    campo_ingrediente.set ingrediente
    campo_passos.set passo
  end
  
end
