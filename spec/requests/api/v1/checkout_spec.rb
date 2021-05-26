describe 'api/v1/checkout' do
  include ApiV1Helpers

  let!(:user) { create :user}
  let!(:item_1) { create :item, price: 2, stock_count: 1 }
  let!(:item_2) { create :item, price: 3, stock_count: 10 }

  describe 'create' do
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

  describe '#update' do
    let!(:order) do
      create :order, user: user do |order|
        order.line_items.new(item: item_1, count: 1)
        order.line_items.new(item: item_2, count: 10)
      end.tap(&:waiting_for_payment)
    end

    it 'enqueues job and return ok response' do
      api_update "checkout/#{order.id}", order_id: order.id

      expect(OrderPaymentJob).to have_been_enqueued.with(order.id)
      expect_status 'ok'
    end
  end
end