require 'rails_helper'

RSpec.describe Api::V1::ProceduresController, type: :controller do
  describe '#index' do
    before do
      ['Foobar', 'Batman'].each do |title|
        Procedure.create(title: title)
      end
    end

    it 'returns error if title is empty' do
      get :index, params: { title: nil }

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(json[:error]).to eq('Title parameter required')
    end

    it 'returns error if no procedures were found' do
      get :index, params: { title: 'test' }

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(json[:error]).to eq('Procedures with such title were not found')
    end

    it 'returns procedures matched by title' do
      get :index, params: { title: 'bat' }

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(json[:procedures].count).to eq(1)
      expect(json[:procedures].first[:title]).to eq('Batman')
    end
  end
end
