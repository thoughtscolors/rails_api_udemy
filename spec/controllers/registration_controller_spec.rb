require 'rails_helper'

describe RegistrationController do
  describe '#create' do
    subject { post :create, params: params }

    context 'when invalid data is provided' do
      let(:params) do
        {
          data: {
            attributes: {
              login: nil,
              password: nil
            }
          }
        }
      end

      it 'should return unprocessable_entity status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not create a user' do
        expect{ subject }.not_to change{ User.count }
      end

      it 'should return error messages in response body' do
        subject
        expect(json['errors']).to include(
          {
            "source" => { 'pointer' => '/data/attributes/login'},
            "detail" => "can't be blank"
          },
          {
            "source" => { 'pointer' => '/data/attributes/password'},
            "detail" => "can't be blank"
          }
        )
      end
    end

    context 'when valid data is provided' do
      let(:params) do
        {
          data: {
            attributes: {
              login: 'jsmith',
              password: 'secret'
            }
          }
        }
      end
      it 'should return http status 201' do
        subject
        expect(response).to have_http_status(:created)
      end

      it 'should create a new user' do
        expect(User.exists?(login: 'jsmith')).to be_falsey
        expect{ subject }.to change{ User.count }.by(1)
        expect(User.exists?(login: 'jsmith')).to be_truthy
      end
    end
  end
end
