require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'given a properly registered new user' do
      it 'will successfully save' do
        @user = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: 'burek',
        )
        expect(@user).to be_valid
      end
    end

    context 'given a new user with no name' do
      it 'will show error for empty name' do
        @user = User.create(
          name: nil,
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: 'burek',
        )
        expect(@user.errors.full_messages[0]).to eq("Name can't be blank")
      end
    end

    context 'given a new user with no email' do
      it 'will show error for empty email' do
        @user = User.create(
          name: 'Alex',
          email: nil,
          password: 'burek',
          password_confirmation: 'burek',
        )
        expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
      end
    end

    context 'given a new user with no password' do
      it 'will show error for empty password' do
        @user = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: nil,
          password_confirmation: 'burek',
        )
        expect(@user.errors.full_messages[0]).to eq("Password can't be blank")
      end
    end

    context 'given a new user with no password confirmation' do
      it 'will show error for empty password confirmation' do
        @user = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: nil,
        )
        expect(@user.errors.full_messages[0]).to eq("Password confirmation can't be blank")
      end
    end

    context 'given a new user with where password and password confirmation do not match' do
      it 'will show error for passwords not matching' do
        @user = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: 'chevaps',
        )
        expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
      end
    end
    
    context 'given a new user, the email must not already exist' do
      it 'will show error for email already taken' do
        @user1 = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: 'burek',
        )

        @user2 = User.create(
          name: 'Lex',
          email: 'Alex@Lajv.com',
          password: 'chevaps',
          password_confirmation: 'chevaps',
        )
        expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
      end
    end

    context 'given a new user with a password of fewer than 3 characters' do
      it 'will show error for password too short' do
        @user = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: '12',
          password_confirmation: '12',
        )
        expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 3 characters)")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'given a proper login' do
      it 'will successfully return the appropriate user information' do
        @user_register = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: 'burek',
        )

        @user_login = User.authenticate_with_credentials('alex@lajv.com', 'burek')
        expect(@user_login).to eq(@user_register)
      end
    end
    
    context 'given a login with spaces around email' do
      it 'will successfully return the appropriate user information' do
        @user_register = User.create(
          name: 'Alex',
          email: 'alex@lajv.com',
          password: 'burek',
          password_confirmation: 'burek',
        )

        @user_login = User.authenticate_with_credentials('  alex@lajv.com  ', 'burek')
        expect(@user_login).to eq(@user_register)
      end
    end
    
    context 'given a login with with email having non-matching case' do
      it 'will successfully return the appropriate user information' do
        user = User.create!( # ! throws if creating fails
          name: 'Alex',
          email: 'Alex@lajv.com',
          password: 'burek',
          password_confirmation: 'burek',
        )

        authenticate = User.authenticate_with_credentials('Alex@lajv.com', 'burek')        
        expect(authenticate).to eq(user)
      end
    end
  end
end
