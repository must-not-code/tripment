require 'rails_helper'

RSpec.describe Procedure, type: :model do
  describe '#search_by_title' do
    before do
      ['Foobar', 'man bat', 'Batman', 'foobatbar', 'bat woman'].each do |title|
        Procedure.create(title: title)
      end
    end

    it 'returns procedures by best title match' do
      expect(Procedure.search_by_title('bat').pluck(:title))
        .to eq(['Batman', 'bat woman', 'man bat', 'foobatbar'])
    end
  end
end
