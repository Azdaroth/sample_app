require 'spec_helper'

describe "MicropostPages" do
  
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	after(:all) { User.delete_all }
	before { sign_in user }

	describe "micropost creation" do
		before { visit root_path }

		describe "with invalid information" do
			
			it "should not create a micropost" do
				expect { click_button "Post" }.should_not change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			
			before { fill_in 'micropost_content', with: "Lorem ipsum" }
			it "should create a micropost" do
				expect { click_button "Post" }.should change(Micropost, :count).by(1)
			end
		end
	end

	describe "micropost destruction" do

		before { FactoryGirl.create(:micropost, user: user) }

		describe "as correct user" do
			before { visit root_path }

			it "should delete a micropost" do
				expect { click_link "delete" }.should change(Micropost, :count).by(-1)
			end
		end

		describe "as an incorrect user" do
			
			let(:other_user) { FactoryGirl.create(:user) }
			before do
				sign_in other_user
				visit user_path(user) 
			end 

			it "should not display delete link for other user" do
				page.should_not have_link("delete") 
			end
		end
	end
end
