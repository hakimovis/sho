require 'rails_helper'

describe UseCases::Order::PaymentProcessor do
  let!(:item_1) { create :item, price: 2, stock_count: 1 }
  let!(:item_2) { create :item, price: 3, stock_count: 10 }

  let!(:user) { create :user }
  let!(:order) do
    create :order, user: user do |order|
      order.line_items.new(item: item_1, count: 1)
      order.line_items.new(item: item_2, count: 10)
    end.tap(&:waiting_for_payment)
  end

  let(:notificators) { [SmsNotificator, UserMailer, WebSocketNotificator] }

  def expect_notifications(user, text)
    notificators.each do |one|
      expect(one).to receive(:call).with(user, text)
    end
  end

  describe 'order processing' do
    let(:payment_provider) { double('Payment::DefaultProvider') }

    context 'when payment succeeded' do
      before do
        expect(payment_provider).to receive(:call).with(user.payment_data, 32).and_return true
      end

      it 'send notifications' do
        expect_notifications(user, "Your paiment received")

        described_class.new(order, payment_provider).call
      end
    end

    context 'when payment failed' do
      before do
        expect(payment_provider).to receive(:call).with(user.payment_data, 32).and_return false
      end

      it 'send notifications' do

        expect_notifications(user, "Your paiment failed")

        described_class.new(order, payment_provider).call
      end
    end
  end
end
