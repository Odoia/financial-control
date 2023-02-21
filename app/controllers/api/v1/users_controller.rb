# frozen_string_literal: true

module Api
  module V1
    # api/v1/users_controller
    class UsersController < ApplicationController
      before_action :user_params, only: [:create]

      def initialize(
        user_service_create = ::UserServices::Create
      )
        super()

        @create_user = user_service_create
      end

      def create
        result = create_user.new(user_params:).call

        if result.id.nil?
          error_handler(errors: result.errors, status: 404)
        else
          render status: 201, json: { data: result, status: 201 }
        end
      end

      private

      attr_reader :create_user

      def user_params
        return error_handler if params[:user].blank?

        params.require(:user).permit(:email, :cpf, :password, :phone, :name, :surname)
      end

      def error_handler(errors: 'bad_request', status: 400)
        render nothing: true, status:, json: { errors:, status: }
      end
    end
  end
end
