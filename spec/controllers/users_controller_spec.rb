require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'get#index' do
        it 'renders the user index' do
            allow(subject).to receive(:logged_in?).and_return(true)
            
            get :index
            expect(response).to render_template(:index)
        end
    end
    
    describe 'get#new' do 
      it 'renders form to make a new user' do 
        allow(subject).to receive(:logged_in?).and_return(true)
        
        get :new
        
        expect(response).ro render_template(:new)
      end

    end



    describe 'delete#destroy' do
        let!(:test_user) {create :user}

        before :each do
            allow(subject).to receive(:current_user).and_return(test_user.user)

            delete :destroy, params: {id: test_user.id}
        end

        it 'destroys the user' do
            expect(User.exists?(test_user.id)).to be false
        end

        it 'redirects to users_url' do
            expect(response).to have_http_status(302)
            expect(response).to redirect_to(users_url)
        end
    end
end
