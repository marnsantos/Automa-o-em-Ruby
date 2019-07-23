# LoginPage representa a tela de login
class LoginPage < SitePrism::Page
  set_url '/login'

  element :campo_email, '#user-name'
  element :campo_senha, '#user-password'
  element :botao_entrar, 'button[type=submit]'
  element :logo_user, '.logo-lg'
  element :mensagem, '.help-block'
  element :mensagem_bloq, 'Login é obrigatório.'
  element :logout_sign, 'div a.dropdown-toggle'
  element :logout_out, 'i[class="fa fa-sign-out"]'

  def logar(email, senha)
    campo_email.set email
    campo_senha.set senha
    botao_entrar.click
    sleep 2
  end

  # def logout
  #   logout_sign.click
  #   logout_out.click
  # end
end
