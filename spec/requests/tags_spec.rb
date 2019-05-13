require 'rails_helper'

RSpec.describe 'tags API', type: :request do
  let(:tags) { create_list(:tag, 10) }
  let(:tag_id) { tags.first.id }

  # Test suite for GET api/v1/tags
  describe 'GET /api/v1/tags' do
    before do
      create_list(:tag, 10)
      get '/api/v1/tags'
    end

    it 'returns tags' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET api/v1/tags/:id 
  describe 'GET /api/v1/tags/:id' do
    before { get "/api/v1/tags/#{tag_id}" }

    context 'when the record exists' do
      it 'returns the tag' do
        expect(json).not_to be_empty
        expect(json['data']['id'].to_i).to eq(tag_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST api/v1/tags
  describe 'POST /api/v1/tags' do
    context 'when the request is valid' do
      before { post '/api/v1/tags', params: { "data":{ "type": "undefined",	"id": "undefined",	"attributes":{ "title": "Someday" }}} }

      it 'creates a tag' do
        expect(json['data']['attributes']['title']).to eq('Someday')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT api/v1/tags/:id
  describe 'PUT api/v1/tags/:id' do
    context 'when the record exists' do
      before { put "/api/v1/tags/#{tag_id}", params: { "data": {	"type": "tags", "id": "#{tag_id}", "attributes":{ "title": "Updated Tag Title" } } } }

      it 'updates the record' do
        expect(json['data']['attributes']['title']).to eq('Updated Tag Title')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE api/v1/tags/:id
  describe 'DELETE api/v1/tags/:id' do
    before { delete "/api/v1/tags/#{tag_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
