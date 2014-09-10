require 'test_helper'

feature 'Bank Payment Test' do
  scenario 'sanity' do
    visit root_path
    page.must_have_content 'Hello World'
    page.wont_have_content 'Goobye All!'
  end
end
