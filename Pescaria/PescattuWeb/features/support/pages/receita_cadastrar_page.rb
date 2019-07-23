# CadastrarReceita representa a tela de cadastro de receitas
class CadastrarReceita < SitePrism::Page
  set_url '/recipe-list'

  element :botao_novo, '#new-product'
  element :campo_nome, '#recipe-name'
  element :campo_tempo, '#recipe-time'
  element :campo_qtdpessoas, '#recipe-amount-people'
  element :campo_descricao, '#recipe-description'

  element :bt_add_ingrediente, '#add-ingredient'
  element :campo_ingrediente, '#recipe-ingredient'
  element :bt_add_passo, '#add-step'
  element :campo_passos, '#recipe-description-step'
  element :botao_salvar, 'button.btn-primary'

  def cadastrar(nome, tempo, qtdpessoas, descricao)
    Capybara.default_max_wait_time = 3.to_i
    botao_novo.click
    campo_nome.set nome
    campo_tempo.set tempo
    campo_qtdpessoas.set qtdpessoas
    campo_descricao.set descricao
  end

  def incluir_ingredientes(ingrediente)
    campo_ingrediente.set ingrediente
    bt_add_ingrediente.click
    Capybara.default_max_wait_time = 3.to_i
  end

  def incluir_passos(passo)
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
