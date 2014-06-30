require 'spec_helper'

describe "Static pages" do
  subject { page }

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))

    click_link "Help"
    expect(page).to have_title(full_title('Help'))

    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))

    click_link "Home"
    expect(page).to have_title(full_title('Home'))

    click_link "Sign up now"
    expect(page).to have_title(full_title('Sign up'))
  end

  shared_examples_for "all static pages" do
    it {should have_content(heading)}
    it {should have_title(full_title(page_title))}
  end

  describe "Home page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: user, content: "Loren ipsum")
      FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        expect(page).to have_selector("li##{item.id}", text: item.content)
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) {'Help'}
    let(:page_title) {'Help'}
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) {'Help'}
    let(:page_title) {'About'}
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) {'Contact'}
    let(:page_title) {'Contact'}
    it_should_behave_like "all static pages"
  end
end

