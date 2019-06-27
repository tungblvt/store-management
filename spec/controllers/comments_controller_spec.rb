require "rails_helper"
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
    context "create" do
      let(:manager) {FactoryBot.create :user}
      let(:store) {FactoryBot.create :store, user_id: manager.id}
      let(:valid_attr) {FactoryBot.attributes_for :comment, store_id: store.id}
      describe "logged in" do
        let(:member) {FactoryBot.create :user, role: Settings.role.member.to_i}
        it do
          log_in member
          expect {
            post :create, params: {comment: valid_attr}
          }.to change(Comment, :count).by 1
        end
      end

      describe "not logged in" do
        it do
          post :create, params: {comment: valid_attr}
          expect(response).to redirect_to login_path
        end
      end
    end
end
