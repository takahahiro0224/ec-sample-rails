require 'rails_helper'

feature 'Sign up' do
  background do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario 'メールアドレスとパスワードを設定し、ユーザー登録する' do
    visit root_path
    expect(page).to have_http_status :ok

    click_link 'サインアップ'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    expect { click_button 'Sign up' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address'

    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content 'Your email address has been successfully confirmed.'

    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    click_link 'ログアウト'
    expect(page).to have_content 'Signed out successfully.'

  end
end
