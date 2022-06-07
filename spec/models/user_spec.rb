require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it 'should have no errors if all fields are present' do
      user = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                        password: 'hello world!', password_confirmation: 'hello world!' })
      user.validate
      expect(user.errors.full_messages).to be_empty
    end

    it 'should have an error if first_name is not present' do
      user = User.new({ last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                        password: 'hello world!', password_confirmation: 'hello world!' })
      user.validate
      expect(user.errors.full_messages).to include "First name can't be blank"
    end

    it 'should have an error if last_name is not present' do
      user = User.new({ first_name: 'Matt', email: 'matthieu.pauze@gmail.com',
                        password: 'hello world!', password_confirmation: 'hello world!' })
      user.validate
      expect(user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'should have an error if email is not present' do
      user = User.new({ first_name: 'Matt', last_name: 'Pauze',
                        password: 'hello world!', password_confirmation: 'hello world!' })
      user.validate
      expect(user.errors.full_messages).to include "Email can't be blank"
    end
  end

  describe 'Passwords' do
    it 'should have an error if the password is not present' do
      user = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                        password_confirmation: 'hello world!' })
      user.validate
      expect(user.errors.full_messages).to include "Password can't be blank"
    end

    it 'should have an error if the password_confirmation is not present' do
      user = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                        password: 'hello world!' })
      user.validate
      expect(user.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it 'should have an error if the passwords do not match' do
      user = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                        password: 'hello world!', password_confirmation: 'goodbye world!' })
      user.validate
      expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'should have an error if the password is too short' do
      user = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                        password: 'a', password_confirmation: 'a' })
      user.validate
      expect(user.errors.full_messages).to include 'Password is too short (minimum is 8 characters)'
    end
  end

  describe 'Email' do
    before(:each) do
      User.create({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                    password: 'hello world!', password_confirmation: 'hello world!' })
    end

    it 'should be unique across the system' do
      user2 = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                         password: 'hello world!', password_confirmation: 'hello world!' })

      user2.validate
      expect(user2.errors.full_messages).to include 'Email has already been taken'
    end

    it 'should be unique across the system regardless of capitalisation' do
      user2 = User.new({ first_name: 'Matt', last_name: 'Pauze', email: 'MATTHIEU.pauze@gmail.com',
                         password: 'hello world!', password_confirmation: 'hello world!' })

      user2.validate
      expect(user2.errors.full_messages).to include 'Email has already been taken'
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      User.create({ first_name: 'Matt', last_name: 'Pauze', email: 'matthieu.pauze@gmail.com',
                    password: 'hello world!', password_confirmation: 'hello world!' })
    end

    it 'should return a valid user instance when the password and email match an existing user' do
      user = User.authenticate_with_credentials('matthieu.pauze@gmail.com', 'hello world!')
      expect(user).to be_a User
    end

    it 'should return nil when email and password do not match an existing user' do
      user = User.authenticate_with_credentials('matthieu.pauze@gmail.com', 'WRONG!!!')
      expect(user).to be_nil
    end

    it 'should authenticate a user even if the email is in a different case' do
      user = User.authenticate_with_credentials('MATTHIEU.pauze@gmail.com', 'hello world!')
      expect(user).to be_a User
    end

    it 'should authenticate a user even if the email contains leading/trailing whitespace' do
      user = User.authenticate_with_credentials('     matthieu.pauze@gmail.com    ', 'hello world!')
      expect(user).to be_a User
    end
  end
end
