# CadastrarCategoria representa a tela de cadastro de Categoria de produto
class CadastrarCategoria < SitePrism::Page
    set_url '/product-category-list'
  
    element :botao_novo, '#new-category'
    element :campo_nome, '#category-name'
    element :suce_mensagem, '#message'
    element :campo_obrigatorio, '.help-block'
 
    element :botao_salvar, 'button.btn-primary'
  
  
    def cadastrar_categoria(categoria)
      Capybara.default_max_wait_time = 3.to_i
      botao_novo.click
      campo_nome.set categoria
      botao_salvar.click
    end
  end
  