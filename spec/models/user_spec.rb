require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user model validation' do
    it 'must have a username' do
      user = User.new(password: 'password', password_confirmation: 'password').save
      expect(user).to eq(false)
    end

    it 'must have a password' do
      user = User.new(username: 'example', password_confirmation: 'password').save
      expect(user).to eq(false)
    end

    it 'must have a password confirmation' do
      user = User.new(username: 'example', password: 'password').save
      expect(user).to eq(false)
    end

    it 'password and password confirmation should match' do
      user = User.new(username: 'example', password: 'password', password_confirmation: 'password1').save
      expect(user).to eq(false)
    end

    it 'user created' do
      user = User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      expect(user).to eq(true)
    end

    it 'username must be unique' do
      User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      user2 = User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      expect(user2).to eq(false)
    end
  end
end
