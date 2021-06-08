require 'rails_helper'

RSpec.describe "Searches", type: :request do
  
    it 'returns all nyt bestsellers' do
        get '/searches'

        expect(response).to have_http_status(:success)
    end

    it 'returns select nyt bestseller based off of id' do
        get '/searches/2'

        expect(response).to have_http_status(:success)
    end

    it 'returns nyt best sellers based off params' do
        get "/fetch_data", :params => { :author => "Michelle Obama"}

        expect(response).to have_http_status(:success)
    end
end
