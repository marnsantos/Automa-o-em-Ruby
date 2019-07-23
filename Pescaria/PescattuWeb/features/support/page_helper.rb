Dir[File.join(File.dirname(__FILE__),
              '../pages/*_page.rb')].each { |file| require file }
# Modulos para chamar as classes instanciadas
module Pages
  #------------ LOGIN --------------
  def login_page
    @login_page = LoginPage.new
  end

  def logininvalido_page
    @logininvalido_page = LogininvalidoPage.new
  end

  def produto_cadastrar_page
    @produto_cadastrar_page = CadastrarProdutoPage.new
  end

  def produto_editar_page
    @produto_editar_page = AlterarProdutoPage.new
  end

  def produto_pesquisar_page
    @produto_pesquisar_page = PesquisarProduto.new
  end

  def produto_list_page
    @produto_list_page = ProdutoListPage.new
  end

  def empresa_cadastrar_page
    @empresa_cadastrar_page = CadastrarEmpresa.new
  end

  def empresa_list_page
    @empresa_list_page = EmpresaListPage.new
  end

  def empresa_pesquisar_page
    @empresa_pesquisar_page = EmpresaPesquisar.new
  end

  def empresa_editar_page
    @empresa_editar_page = EmpresaAlterar.new
  end

  def colaborador_pesquisar_page
    @colaborador_pesquisar_page = ColaboradorPesquisar.new
  end

  def receita_pesquisar_page
    @receita_pesquisar_page = PesquisarReceita.new
  end
  
  def receita_cadastrar_page
    @receita_cadastrar_page = CadastrarReceita.new
  end

  def receita_list_page
    @receita_list_page = ReceitaList.new
  end

  def receita_editar_page
    @receita_editar_page = ReceitaEditar.new
  end

  def categoria_cadastrar_page
    @categoria_cadastrar_page = CadastrarCategoria.new
  end

  def categoria_editar_page
    @categoria_editar_page = AlterarCategoria.new
  end
end
