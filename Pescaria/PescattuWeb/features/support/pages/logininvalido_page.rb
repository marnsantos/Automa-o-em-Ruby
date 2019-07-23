# LoginInvalidoPage representa a tela de login
class LogininvalidoPage < SitePrism::Page
  set_url '/login'

  element :campo_email, '#user-name'
  element :campo_senha, '#user-password'
  element :botao_entrar, 'button[type=submit]'
  element :mensagem, 'div.alert.alert-error'

  #   element :logout_sign, 'div a.dropdown-toggle'
  #   element :logout_out, 'i[class="fa fa-sign-out"]'

  def tentarlogar(email, senha)
    campo_email.set email
    campo_senha.set senha
    botao_entrar.click
  end
end
