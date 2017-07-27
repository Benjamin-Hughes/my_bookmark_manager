feature 'Creating links' do
  scenario 'add bookmark' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com'
    fill_in 'title', with: 'makersacademy'
    click_button 'Create link'
    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('makersacademy')
    end

  end
end
