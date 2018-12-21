require 'rails_helper'

describe ArticlesController do

  describe '#index' do

    it 'should return reponse success code' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      create_list :article, 2
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end

  end

end
