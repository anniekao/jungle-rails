require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user1 = User.create(:email => "Jane@doe.com", :password => "pw12345",
                       :password_confirmation => "pw12345", :first_name => "jane", :last_name => "doe")
  end    
  
  describe 'Validations' do
    it 'should be valid when the password and password confirmation are the same' do
      @user = User.new(:email => "john@doe.com", :password => "pw1234",
                       :password_confirmation => "pw1234", :first_name => "jane", :last_name => "doe")
      
      expect(@user).to be_valid
    end
    
    it 'should be invalid when the password and password confirmation are not the same' do
      @user = User.new(:email => "john@doe.com", :password => "pw1234",
                       :password_confirmation => "pw12345", :first_name => "jane", :last_name => "doe")
      
      expect(@user).to_not be_valid
    end

    it 'should be invalid when the email is not unique' do      
      @user2 = @user1.dup
      expect(@user2).to_not be_valid
    end

    it 'should require email' do
       @user = User.new(:email => nil, :password => "pw1234",
                       :password_confirmation => "pw12345", :first_name => "jane", :last_name => "doe")

      expect(@user).to_not be_valid
      expect(@user.errors[:email]).to_not be_empty
    end
    
    it 'should require first name' do
       @user = User.new(:email => "john@doe.com", :password => "pw1234",
                       :password_confirmation => "pw12345", :first_name => nil, :last_name => "doe")
      
      expect(@user).to_not be_valid
      expect(@user.errors[:first_name]).to_not be_empty
    end
    
    it 'should require last name' do
       @user = User.new(:email => "john@doe.com", :password => "pw1234",
                       :password_confirmation => "pw12345", :first_name => "jane", :last_name => nil)
      
      expect(@user).to_not be_valid
      expect(@user.errors[:last_name]).to_not be_empty
    end
    
    it 'should be invalid if the password is less than the min length' do
       @user = User.new(:email => "john@doe.com", :password => "pw123",
                       :password_confirmation => "pw123", :first_name => "jane", :last_name => "doe")
      
      expect(@user).to_not be_valid
      expect(@user.errors[:password]).to_not be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns a user instance when email and password are valid' do
      authenticated = User.authenticate_with_credentials(@user1[:email], "pw12345")
      expect(authenticated).to be_an_instance_of(User)
    end
    
    it 'returns nil when email is not valid' do
      authenticated = User.authenticate_with_credentials('none@hotmail.com', "pw12345")
      expect(authenticated).to be_nil
    end

    it 'returns nil when password is not valid' do
       authenticated = User.authenticate_with_credentials(@user1[:email], "pw123457")
      expect(authenticated).to be_nil
    end
  end
end
