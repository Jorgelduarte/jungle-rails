require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

        it "save a user" do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            expect(User.find(@user.id)).not_to be_nil
        end


        it "password and password_confirmation needs to be the same" do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '1234567')
            expect(@user.errors.full_messages_for(:password_confirmation)).to eq ["Password confirmation doesn't match Password"]
        end


        it "Emails must be unique (not case sensitive)" do
            @user1 = User.create(first_name: 'Don', last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            @user2 = User.create(first_name: 'DonB', last_name: 'BurcksB', email: 'DON@GMAIL.com', password: '123456B', password_confirmation: '123456B')
            expect(@user2.errors.full_messages_for(:email)).to eq ["Email has already been taken"]
        end


        it "without a first_name it is impossible to save" do
            @user = User.create(first_name: nil, last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            expect(@user.errors.full_messages_for(:first_name)).to eq ["First name can't be blank"]
        end


        it "without a last_name it is impossible to save" do
            @user = User.create(first_name: 'Don', last_name: nil, email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            expect(@user.errors.full_messages()).to eq ["Last name can't be blank"]
        end


        it "without a email it is impossible to save" do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: nil, password: '123456', password_confirmation: '123456')
            expect(@user.errors.full_messages_for(:email)).to eq ["Email can't be blank"]
        end


        it "Password should have a minimum length to save" do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: nil, password: '1', password_confirmation: '1')
            expect(@user.errors.full_messages_for(:password)).to eq ["Password is too short (minimum is 6 characters)"]
        end
    end

    describe '.authenticate_with_credentials' do

        it 'authenticate a user with credentials' do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            expect(User.authenticate_with_credentials('don@gmail.com', '123456')).to eq @user
        end
  
        it 'authenticate a user with credentials using spaces in the email' do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            expect(User.authenticate_with_credentials(' don@gmail.com', '123456')).to eq @user
        end
  
        it 'authenticate a user with credentials using wrong case in the email' do
            @user = User.create(first_name: 'Don', last_name: 'Burcks', email: 'don@gmail.com', password: '123456', password_confirmation: '123456')
            expect(User.authenticate_with_credentials('DON@gmail.com', '123456')).to eq @user
        end
    end
  end