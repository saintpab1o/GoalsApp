require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email) }
    it {should validate_presence_of(:password_digest) }
    it {should validate_length_of(:password).is_at_least(6)}
    it {should validate_presence_of(:session_token)}
  end
  
  describe 'uniqueness' do
    before :each do
      create :user
    end
    
    it {should validate_uniqueness_of(:email)}
    it {should validate_uniqueness_of(:session_token)}
  end
  #association tests
  
  #class methods
  describe 'find_by_credentials' do
    let!(:test_user) { create :user}
    
    context 'with valid credentials' do
      it 'should return user' do
        expect(User.find_by_credentials(user.email,"password")).to be test_user
      end
    end

    context 'with invalid credentials' do 
      it 'should return nil' do
        expect(user.find_by_credentials(wrong_email,wrong_pw)).to be nil
      end
    end

  end

  #reset_session_token
  describe 'reset_session_token!' do
    let!(:user) { create :user}

    it 'should generate a new session token' do
      expect(user.reset_session_token!).not_to be (:session_token) 
    end

  end

end
