require 'rails_helper'

describe 'UsersController', type: :request do
  before do
    I18n.default_locale = :en
    post '/api/v1/user', params:, headers: { 'ACCEPT' => 'application/json' }
  end

  let(:body) { JSON.parse response.body }

  context 'When create a user' do
    context 'When use a valid params' do
      context 'When use a POST url' do
        let(:params) do
          { 'user': {
            email: "#{(Time.now.to_f * 1000).to_i}#{Faker::Internet.email}",
            cpf: Faker::Code.isbn,
            password: '1Asdert@',
            phone: Faker::PhoneNumber.subscriber_number(length: 11),
            name: Faker::Name.first_name,
            surname: "#{Faker::Name.middle_name} #{Faker::Name.last_name}"
          } }
        end

        it 'must be return status 201' do
          expect(body['status']).to eq 201
        end

        it 'must be return user name' do
          expect(body['data']['name']).to eq params[:user][:name]
        end
      end
    end

    context 'When use a invalid params' do
      context 'When use a body without user' do
        let(:params) { { 'name': 'user name' } }

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end

      context 'When use a body without one parameter' do
        let(:params) { { 'user': {} } }

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end

      context 'When try send a empty body' do
        let(:params) {}

        it 'must be return status 400' do
          expect(body['status']).to eq 400
        end
      end
    end
  end
end
