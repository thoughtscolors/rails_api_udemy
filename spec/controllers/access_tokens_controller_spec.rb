require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe '#create' do
    context 'when invalid request' do
      it 'should return 401 status code' do
        post :create
        expect(response).to have_http_status_code(401)
      end
    end

    context 'when successful request' do

    end
  end
end
