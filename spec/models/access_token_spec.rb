require 'rails_helper'

RSpec.describe AccessToken, type: :model do

  describe '#validations' do
    it 'should have a valid factory' do

    end

    it 'should validate token' do

    end
  end

  describe '#new' do
    it 'should have a token present after initialization' do
      expect(AccessToken.new.token).to be_present
    end

    it 'should generate a unique token' do
      expect{ user.create_access_token }.to change{ AccessToken.count }.by(1)
      expect{ user.build_access_token }.to be_valid
    end
  end

end
