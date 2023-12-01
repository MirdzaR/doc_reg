require 'rails_helper'

RSpec.describe Document, type: :model do
  context 'document model validation' do
    it 'must have a title' do
      user = User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      document = Document.new(user_id: user, body: "Text part in the body field").save
      expect(document).to eq(false)
    end

    it 'must have a body' do
      user = User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      document = Document.new(user_id: user, title: "Title").save
      expect(document).to eq(false)
    end

    it 'body must be at least 10 characters long' do
      user = User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      document = Document.new(user_id: user, title: "Title", body: "Text part").save
      expect(document).to eq(false)
    end

    it 'document created' do
      user = User.new(username: 'example', password: 'password', password_confirmation: 'password').save
      document = Document.new(user_id: user, title: "Title", body: "Text part in the body field").save
      expect(document).to eq(true)
    end
  end
end
