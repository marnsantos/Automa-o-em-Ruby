# Esta classe representa a tela Alterar Categoria de Produtos
class AlterarCategoria < SitePrism::Page
    set_url '/product-category-list'
  
    element :table_busca, '#example2'
    element :botao_editar, 'i.fa.fa-2x.fa-edit'
    element :campo_categoria, '#category-name'
    element :botao_salvar, 'button.btn-primary'
    element :botao_cancelar, 'button.btn-default'
  
    def buscar(categoria)
      Capybara.default_max_wait_time = 3.to_i
      @categoria = categoria
      table_busca.find('tr td:ntd-child(2)').text
      
    end

    def pesquisar_codigo(empresa)
      @empresa = empresa
      campo_cnpj.set @empresa
      botao_pesquisar.click
      table_empresa.find('tr td:nth-child(1)').text
    end
  
    def alterar_categoria(categoria)
      Capybara.default_max_wait_time = 3.to_i
      @categoria = categoria
      botao_editar.click
      campo_categoria.set categoria
      botao_salvar.click
    end
  end
  