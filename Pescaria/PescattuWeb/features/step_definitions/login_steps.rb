Dado('que faço login com {string} e {string}') do |email, senha|
  login_page.load
  login_page.logar(email, senha)
end

Então('devo ver a logo {string}') do |logo_home|
  expect(login_page.logo_user.text).to have_content logo_home
end
