describe '/api/v1/users', type: :request do
  include ApiV1Helpers

  describe 'create' do
    let(:params) { {name: 'user_1', email: 'foo@localhost', phone: '79000000000', payment_data: 'sberbank'} }

    it 'creates user' do
      api_post :users, params

      expect_status 'ok'

      user = User.first
      expect(user.name).to eq params[:name]
      expect(user.email).to eq params[:email]
      expect(user.phone).to eq params[:phone]
      expect(user.payment_data).to eq params[:payment_data]
    end

    it 'return wrong_format error' do
      api_post :users, {email: 'invalid', phone: '3479422022'}

      expect_status 'wrong_format'
      expect(parsed_response['message']).
        to eq "name can't be blank, email is invalid, phone is invalid, payment_data can't be blank"
    end
  end

  describe 'show' do
    let!(:user) { create :user }

    it 'return user info' do
      api_get "users/#{user.id}"

      expect_status 'ok'
      expect(parsed_response['data']).to eq(user.attributes.slice("id", "email", "name", "phone", "payment_data"))
    end

    it "return not_found error" do
      api_get "users/0"
      expect_status 'not_found'
    end
  end
end