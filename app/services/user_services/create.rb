# frozen_string_literal: true

module UserServices
  class Create
    def initialize(user_params)
      user_params = user_params[:user_params]
      @email = user_params['email']
      @cpf = user_params['cpf']
      @password = user_params['password']
      @phone = user_params['phone']
      @name = user_params['name']
      @surname = user_params['surname']
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
