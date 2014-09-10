require 'test_helper'

feature 'Bank Payment Test' do
  before do
    visit engine_routes.pay_root_path
  end

  scenario 'sanity' do
    page.must_have_content 'Su orden'
  end

  scenario 'display order info' do
    page.must_have_css '.product-name', text: 'eBook Aprendiendo Ruby on Rails 4.0'
    page.must_have_css '.product-price', text: 'MXN$ 200.00 x 1'
  end

  scenario 'display order details' do
    within('#new_pay') do
      page.must_have_css '#pay_email'
    end
  end
end
