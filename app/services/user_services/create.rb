# frozen_string_literal: true

module UserServices
  # UserServices::Create
  class Create
    def initialize(user_params)
      params = user_params[:user_params]&.with_indifferent_access
      @email = params['email']
      @cpf = params['cpf']
      @password = params['password']
      @phone = params['phone']
      @name = params['name']
      @surname = params['surname']
    end

    def call
      user_create
    end

    private

    attr_reader :email, :cpf, :password, :phone, :name, :surname

    def user_create
      ::User.new.tap do |u|
        u.email = email
        u.cpf = cpf
        u.password = password
        u.phone = phone
        u.name = name
        u.surname = surname
        u.save
      end
    end
  end
end
