require 'rails_helper'

describe UserAuthenticator::Standard do
  describe '#perform' do
    let(:authenticator) { described_class.new('jsmith', 'password')}
    subject { authenticator.perform }

    shared_examples_for 'invalid_authentication' do
      before { user }
      it 'should raise an error' do
        expect{ subject }.to raise_error(
          UserAuthenticator::Standard::AuthenticationError
        )
        expect(authenticator.user).to be_nil
      end
    end

    context 'when login is invalid' do
      let(:user) { create :user, login: 'ddeo', password: 'password' }
      it_behaves_like 'invalid_authentication'
    end

    context 'when password is invalid' do
      let(:user) { create :user, login: 'jsmith', password: 'secret' }
      it_behaves_like 'invalid_authentication'
    end

    context 'when authentication is successful' do
      let(:user) { create :user, login: 'jsmith', password: 'password' }

      it 'should set the user found in db' do
        expect{ subject }.not_to change{ User.count }
        expect(authenticator.user).to eq(user)
      end

      it 'should create and set user access_token' do
        expect{ subject }.to change{ AccessToken.count }.by(1)
        expect(authenticator.access_token).to be_present
      end
    end
  end
end
