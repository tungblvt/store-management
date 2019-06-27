require "rails_helper"
include SessionsHelper

RSpec.describe CategoriesController, type: :controller do
  let(:user) {FactoryBot.create :user }
  let(:store) {FactoryBot.create :store, user_id: user.id }
  subject {FactoryBot.create :category, store_id: store.id}
  let(:valid_attributes) {FactoryBot.attributes_for :category, store_id: store.id}
  let(:invalid_attributes) {FactoryBot.attributes_for :category, name: ""}

  context "user is administrator" do
    before do
      admin = FactoryBot.create :user, role: Settings.role.admin.to_i
      log_in admin
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to render_template "index"
      end
    end

    describe "GET #new" do
      it do
        get :new
        expect(response).to render_template "new"
      end
    end

    describe "GET #edit" do
      it do
        get :edit, params: {id: subject}
        expect(response).to render_template "edit"
      end

      context "resource not found" do
        it do
          get :edit, params: {id: 0}
          expect(response.status).to eq(404)
        end
      end
    end

    describe "GET #show" do
      context "category exist" do
        it do
          get :show, params: {id: subject.id}
          expect(response).to render_template "show"
        end
      end

      context "category is not exist" do
        it do
          get :show, params: {id: 0}
          expect(response.status).to eq(404)
        end
      end
    end

    describe "POST #create" do
      context "valid params" do
        it do
          expect {
            post :create, params: {category: valid_attributes}
          }.to change(Category, :count).by 1
        end

        it do
          post :create, params: {category: valid_attributes}
          expect(response).to redirect_to categories_path
        end
      end

      context "invalid params" do
        it do
          post :create, params: {category: valid_attributes}
          expect(response).to redirect_to categories_path
        end
      end
    end

    describe "PATCH #update" do
      context "valid params" do
        let(:update_params) {FactoryBot.attributes_for :category, name: "name has been changed", store_id: store.id }
        it do
          patch :update, params: {id: subject.id, category: update_params}
          subject.reload
          expect(subject.name).to eq update_params[:name]
        end

        it do
          patch :update, params: {id: subject.id, category: update_params}
          expect(response).to redirect_to edit_category_path(subject)
        end
      end

      context "invalid params" do
        let(:update_params) {FactoryBot.attributes_for :category, name: "name has been changed", store_id: store.id }
        it do
          patch :update, params: {id: 0, category: update_params, store_id: store.id}
          expect(response.status).to eq(404)
        end
      end
    end

    describe "DELETE #destroy" do
      context "category exist" do
        it do
          category = Category.create! valid_attributes
          expect {
            delete :destroy, params: {id: category.id}
          }.to change(Category, :count).by -1
        end

        it do
          category = Category.create! valid_attributes
          delete :destroy, params: {id: category}
          expect(response).to redirect_to categories_path
        end
      end

      context "category is not exist" do
        it do
          delete :destroy, params: {id: 0}
          expect(response.status).to eq(404)
        end
      end
    end
  end

  context "user is manager" do
    let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
    before do
      log_in manager
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to render_template "index"
      end
    end

    describe "GET #new" do
      it do
        get :new
        expect(response).to render_template "new"
      end
    end

    describe "GET #edit" do

      context "manager owned category" do
        let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
        let(:store_owned) {FactoryBot.create :store, user_id: manager.id}
        let(:category_owned) {FactoryBot.create :category, store_id: store_owned.id}
        it do
          get :edit, params: {id: category_owned}
          expect(response).to render_template "edit"
        end
      end

      context "manager do not owned category" do
        let(:other_manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
        let(:store_not_owned) {FactoryBot.create :store, user_id: other_manager.id}
        let(:category_not_owned) {FactoryBot.create :category, store_id: store_not_owned.id}
        it do
          get :edit, params: {id: category_not_owned}
          expect(response.status).to eq(404)
        end
      end

      context "resource not found" do
        it do
          get :edit, params: {id: 0}
          expect(response.status).to eq(404)
        end
      end
    end

    describe "GET #show" do

      context "manager owned category and category exist" do
        let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
        let(:store_owned) {FactoryBot.create :store, user_id: manager.id}
        let(:category_owned) {FactoryBot.create :category, store_id: store_owned.id}
        it do
          get :show, params: {id: category_owned}
          expect(response).to render_template "show"
        end
      end

      context "category is not exist" do
        it do
          get :show, params: {id: 0}
          expect(response.status).to eq(404)
        end
      end
    end

    describe "POST #create" do
      context "valid params" do
        it do
          expect {
            post :create, params: {category: valid_attributes}
          }.to change(Category, :count).by 1
        end

        it do
          post :create, params: {category: valid_attributes}
          expect(response).to redirect_to categories_path
        end
      end

      context "invalid params" do
        it do
          post :create, params: {category: valid_attributes}
          expect(response).to redirect_to categories_path
        end
      end
    end

    describe "PATCH #update" do
      context "valid params" do
        let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
        let(:store_owned) {FactoryBot.create :store, user_id: manager.id}
        let(:category_owned) {FactoryBot.create :category, store_id: store_owned.id}
        let(:update_params) {FactoryBot.attributes_for :category, name: "name has been changed", store_id: store_owned.id }

        it do
          patch :update, params: {id: category_owned.id, category: update_params}
          category_owned.reload
          expect(category_owned.name).to eq update_params[:name]
        end

        it do
          patch :update, params: {id: category_owned.id, category: update_params}
          expect(response).to redirect_to edit_category_path(category_owned)
        end
      end

      context "invalid params" do
        let(:update_params) {FactoryBot.attributes_for :category, name: "name has been changed", store_id: store.id }
        it do
          patch :update, params: {id: 0, category: update_params, store_id: store.id}
          expect(response.status).to eq(404)
        end
      end
    end

    describe "DELETE #destroy" do
      context "category exist" do
        it do
          store = FactoryBot.create :store, user_id: current_user.id
          category = FactoryBot.create :category, store_id: store.id
          expect {
            delete :destroy, params: {id: category.id}
          }.to change(Category, :count).by -1
        end
      end

      context "category is not exist" do
        it do
          delete :destroy, params: {id: 0}
          expect(response.status).to eq(404)
        end
      end
    end
  end

  context "user is member" do
    let(:member) {FactoryBot.create :user, role: Settings.role.member.to_i}
    before do
      log_in member
    end

    describe "GET #index" do
      it do
        get :index
        expect(response.status).to eq(404)
      end
    end

    describe "GET #new" do
      it do
        get :new
        expect(response.status).to eq(404)
      end
    end

    describe "GET #edit" do
      let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
      let(:store) {FactoryBot.create :store, user_id: manager.id}
      let(:category) {FactoryBot.create :category, store_id: store.id}

      it do
        get :edit, params: {id: category.id}
        expect(response.status).to eq(404)
      end
    end

    describe "GET #show" do

      let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
      let(:store) {FactoryBot.create :store, user_id: manager.id}
      let(:category) {FactoryBot.create :category, store_id: store.id}

      it do
        get :edit, params: {id: category.id}
        expect(response.status).to eq(404)
      end
    end

    describe "POST #create" do
      let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
      let(:store) {FactoryBot.create :store, user_id: manager.id}
      let(:category) {FactoryBot.create :category, store_id: store.id}

      it do
        get :edit, params: {id: category.id}
        expect(response.status).to eq(404)
      end
    end

    describe "PATCH #update" do
      let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
      let(:store) {FactoryBot.create :store, user_id: manager.id}
      let(:category) {FactoryBot.create :category, store_id: store.id}

      it do
        get :edit, params: {id: category.id}
        expect(response.status).to eq(404)
      end
    end

    describe "DELETE #destroy" do
      let(:manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
      let(:store) {FactoryBot.create :store, user_id: manager.id}
      let(:category) {FactoryBot.create :category, store_id: store.id}

      it do
        get :edit, params: {id: category.id}
        expect(response.status).to eq(404)
      end
    end
  end
end
