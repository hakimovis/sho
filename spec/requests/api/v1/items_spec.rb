describe 'api/v1/items' do
  include ApiV1Helpers

  describe 'index' do
    let!(:items) do
      create_list :item, 10
    end

    it 'return items info' do
      api_get :items

      expect_status 'ok'

      data = parsed_response['data']
      expect(data.count).to eq 10

      items.each do |item|
        expect(data).to include(item.attributes.slice('id', 'name', 'stock_count').merge('price' => item.price.round(2)))
      end
    end
  end
end