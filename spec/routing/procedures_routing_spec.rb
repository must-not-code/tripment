require 'rails_helper'

RSpec.describe Api::V1::ProceduresController, type: :routing do
  it 'routes to #index' do
    expect(get('/api/v1/procedures')).to route_to('api/v1/procedures#index', format: :json)
  end
end
