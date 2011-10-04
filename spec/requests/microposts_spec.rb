require 'spec_helper'

describe "Microposts" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
  end
  
  describe "creation" do
    
    describe "failure" do
    
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
    end

    describe "success" do
  
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        content2 = "1 micropost"
        content3 = "2 microposts"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
          response.should have_selector("span.microposts", :content => content2)
        end.should change(Micropost, :count).by(1)
      end

      it "should make two microposts" do
        content = "Lorem ipsum dolor sit amet"
        content2 = "1 micropost"
        content3 = "2 microposts"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
          response.should have_selector("span.microposts", :content => content2)
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
          response.should have_selector("span.microposts", :content => content3)
        end.should change(Micropost, :count).by(2)
      end
    end
  end
end
