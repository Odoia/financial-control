# frozen_string_literal: true

Rails.application.routes.draw do
  post 'api/v1/user', to: 'api/v1/users#create'
end
