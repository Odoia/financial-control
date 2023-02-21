require 'rails_helper'

describe 'UserServices::Create', type: :service do
  subject { UserServices::Create.new(user_params:) }
  let(:user_params) {}
  before do
    I18n.default_locale = :en
  end

  context 'When create a user using user services' do
    context 'When use a valid params' do
      let(:user_params) do
        {
          email: "#{(Time.now.to_f * 1000).to_i}#{Faker::Internet.email}",
          cpf: Faker::Code.isbn,
          password: '1Asdert@',
          phone: Faker::PhoneNumber.subscriber_number(length: 11),
          name: Faker::Name.first_name,
          surname: "#{Faker::Name.middle_name} #{Faker::Name.last_name}"
        }
      end

      it 'must be return a created User with a user_params' do
        result = subject.call

        user_params.each { |key, _value| expect(result.send(key)).to eq user_params[key.to_sym] }
      end
    end

    xcontext 'When use a invalid params' do
      let(:user_params) do
        {
          email: "#{(Time.now.to_f * 1000).to_i}#{Faker::Internet.email}",
          cpf: Faker::Code.isbn,
          password: '1Asdert@',
          phone: Faker::PhoneNumber.subscriber_number(length: 11),
          name: Faker::Name.first_name,
          surname: Faker::Code.isbn,
        }
      end
      it 'must be return nil' do
        result = subject.call

        user_params.each { |key, _value| expect(result.send(key)).to be_nil }
      end
    end
  end
end
