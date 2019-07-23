Dado("que seleciono a categoria {string}") do |categoria|
  @categoria = categoria
  categoria_editar_page.load
  @resultado = categoria_editar_page.pesquisar(categoria)
  end
  
  Quando("edito esta categoria {string}") do |categoria|
    categoria_editar_page.alterar_categoria(@resultado, categoria)
  end
  
  Entao("exibe mensagem {string}") do |mensagem|
    expect(categoria_list_page.alerta_messagem.text).to have_content mensagem
  end