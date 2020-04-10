# frozen_string_literal: true

ActiveAdmin.register AuthenticationProof do
  permit_params :user_id, :time, :authenticated
end
