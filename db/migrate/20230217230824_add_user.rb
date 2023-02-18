# frozen_string_literal: true

# app/model/users
class AddUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, :surname, :cpf, :phone, :password_digest
      t.string :email, index: { unique: true, name: 'unique_emails' }
      t.boolean :admin, null: false, default: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
