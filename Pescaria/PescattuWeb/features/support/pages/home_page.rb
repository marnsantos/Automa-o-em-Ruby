
# HomePage representa a tela de principal do sistema
class HomePage < SitePrism::Page
  set_url '/product-list'

  element :botao_novo, '#new-product'
  element :logo_page, 'span.logo-lg'
end
