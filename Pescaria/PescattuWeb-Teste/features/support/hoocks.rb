Before('@auth') do
  login_page.load
  login_page.logar('web@gmail.com', '123456')
end

After do |scenario|
  if scenario.failed?
    sleep 3
    $nome_cenario = page.driver.browser.screenshot_as(:base64)
    embed("data:image/png;base64,#{$nome_cenario}", 'image/png')
  end
  # Capybara.reset_sessions!
end
