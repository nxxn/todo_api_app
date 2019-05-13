require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  let(:tasks) { create_list(:task, 10) }
  let(:task_id) { tasks.first.id }

  # Test suite for GET api/v1/tasks
  describe 'GET /api/v1/tasks' do
    before do
      create_list(:task, 10)
      get '/api/v1/tasks'
    end

    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET api/v1/tags with tags
  describe 'GET /api/v1/tasks' do
    before do
      tag = create(:tag)
      tasks.first.tags << tag

      get '/api/v1/tasks'
    end

    it 'returns tasks with tags' do
      # puts json
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
      expect(json['data'][0]['relationships']['tags']['data'][0]['id'].to_i).to eq(task_id)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET api/v1/tasks/:id
  describe 'GET /api/v1/tasks/:id' do
    before { get "/api/v1/tasks/#{task_id}" }

    context 'when the record exists' do
      it 'returns the task' do
        expect(json).not_to be_empty
        expect(json['data']['id'].to_i).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST api/v1/tasks
  describe 'POST /api/v1/tasks' do
    context 'when the request is valid' do
      before { post '/api/v1/tasks', params: { "data":{ "type": "undefined",	"id": "undefined",	"attributes":{ "title": "Do Homework" }}} }

      it 'creates a task' do
        expect(json['data']['attributes']['title']).to eq('Do Homework')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT api/v1/tasks/:id
  describe 'PUT api/v1/tasks/:id' do
    context 'when the record exists' do
      before { put "/api/v1/tasks/#{task_id}", params: { "data": {	"type": "tasks", "id": "#{task_id}", "attributes":{ "title": "Updated Task Title" } } } }

      it 'updates the record' do
        expect(json['data']['attributes']['title']).to eq('Updated Task Title')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for PUT api/v1/tasks/:id with tags
  describe 'PUT api/v1/tasks/:id' do
    context 'when the record exists' do
      before { put "/api/v1/tasks/#{task_id}", params: { "data": {	"type": "tasks", "id": "#{task_id}", "attributes":{ "title": "Updated Task Title", "tags": ["Urgent", "Home"] } } } }

      it 'updates the record' do
        expect(json['data']['attributes']['title']).to eq('Updated Task Title')
      end

      it 'adds tags' do
        puts json['data']['relationships']['tags']['data'].size
        expect(json['data']['relationships']['tags']['data'].size).to eq(2)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE api/v1/tasks/:id
  describe 'DELETE api/v1/tasks/:id' do
    before { delete "/api/v1/tasks/#{task_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
