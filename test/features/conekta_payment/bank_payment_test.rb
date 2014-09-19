require 'test_helper'

feature 'Bank Payment Test' do
  before do
    visit engine_routes.pay_root_path
  end

  after do
    WebMock.reset!
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
      page.must_have_css '#card_number'
      page.must_have_css '#card_name'
      page.must_have_css '#card_expiry'
      page.must_have_css '#card_cvc'
      page.must_have_css '#pay_action'
    end
  end

  scenario 'display errors on submit when data incomplete' do
    within('#new_pay') do
      click_button 'Pagar MXN$ 200.00'

      page.must_have_css '.error-area'
      page.all('.error').length.must_equal 5
    end
  end

  scenario 'display confirmation page on successful payment' do
    within('#new_pay') do
      fill_in 'pay_email', with: 'sample@email.com'
      #fill_in 'card_number', with: '4242424242424242'
      page.execute_script("$('#card_number').val('4242 4242 4242 4242')")
      fill_in 'card_name', with: 'John Doe'
      #fill_in 'card_expiry', with: '01 20'
      page.execute_script("$('#card_expiry').val('01 / 20')")
      fill_in 'card_cvc', with: '987'

      click_button 'Pagar MXN$ 200.00'
    end

    page.must_have_content 'Pay#create'
  end
end
