describe 'api/v1/checkout' do
  include ApiV1Helpers

  describe 'create' do
    let!(:user) { create :user}
    let!(:item_1) { create :item, stock_count: 1 }
    let!(:item_2) { create :item, stock_count: 10 }

    context 'when checkout is successful' do
      it 'return checkout result' do
        api_post :checkout, {user_id: user.id, items: [{id: item_1.id, count: 1}]}

        expect_status 'ok'

        expected_data = {
          'checkout_status' => 'accepted',
          'order' => {
            'status' => 'waiting_for_payment',
            'items' => [
              {'id' => item_1.id, 'status' => 'available'}
            ]
          }
        }

        expect(parsed_response['data']).to eq expected_data
      end
    end

    context 'when checkout failed' do
      it 'return checkout result' do
        requested_items = [
          {id: item_1.id, count: 2},
          {id: item_2.id, count: 10},
          {id: -1, count: 15}
        ]
        api_post :checkout, {user_id: user.id, items: requested_items}

        expect_status 'ok'

        expected_data = {
          'checkout_status' => 'declined',
          'order' => {
            'status' => 'draft',
            'items' => [
              {'id' => -1, 'status' => 'not_found'},
              {'id' => item_1.id, 'status' => 'shortage'},
              {'id' => item_2.id, 'status' => 'available'}
            ]
          }
        }
        expect(parsed_response['data']).to eq expected_data
      end
    end
  end
end