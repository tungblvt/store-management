require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:valid_attributes) {FactoryBot.attributes_for :user}
  let(:invalid_attributes) {FactoryBot.attributes_for :user, name: ""}

  context "user is admin" do
    before do
      admin = FactoryBot.create :user, role: Settings.role.admin.to_i
      @current_user = admin
      log_in admin
    end

    describe "GET #index" do
      let!(:users) { FactoryBot.create_list :user, 2 }

      it "assigns @users" do
        expect(assigns(:users)).to eq assigns(:users)
      end

      it do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      it "assigns @user" do
        expect(assigns(:user)).to eq assigns(:user)
      end

      it do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "assigns @user" do
          expect(assigns(:user)).to eq assigns(:user)
        end

        it do
          expect {
            post :create, params: {user: valid_attributes}
          }.to change(User, :count).by 1
        end

        it do
          post :create, params: {user: valid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {user: invalid_attributes}
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      context "resource exist" do
        it do
          get :edit, params: {id: user}
          expect(response).to render_template :edit
        end
      end

      context "resource not found" do
        it do
          get :edit, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        it "assigns @user" do
          expect(assigns(:user)).to eq assigns(:user)
        end

        let(:new_attributes) do
          FactoryBot.attributes_for :user, name: "name changed"
        end

        it do
          patch :update, params: {id: user, user: new_attributes}
          user.reload
          expect(user.name).to eq new_attributes[:name]
        end

        it do
          patch :update, params: {id: user, user: new_attributes}
          expect(response).to redirect_to user
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: user, user: invalid_attributes}
          expect(response).to render_template :edit
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do
      context "resource exist" do
        it "assigns @user" do
          user = User.create! valid_attributes
          expect(assigns(:user)).to eq assigns(:user)
        end

        it do
          user = User.create! valid_attributes
          delete :destroy, params: {id: user}
          expect(flash[:success]).to eq "Delete successfully"
        end

        it do
          user = User.create! valid_attributes
          expect {
            delete :destroy, params: {id: user}
          }.to change(User, :count).by -1
        end

        it do
          user = User.create! valid_attributes
          delete :destroy, params: {id: user}
          expect(response).to redirect_to users_path
        end
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: -1}
          expect(response).to redirect_to root_url
        end
      end
    end
  end

  context "user is manager" do
    before do
      manager = FactoryBot.create :user, role: Settings.role.manager.to_i
      @current_user = manager
      log_in manager
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #new" do
      it "assigns @user" do
        expect(assigns(:user)).to eq assigns(:user)
      end

      it do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {user: valid_attributes}
          }.to change(User, :count).by 1
        end

        it do
          post :create, params: {user: valid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {user: invalid_attributes}
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      context "resource exist" do
        it do
          get :edit, params: {id: user}
          expect(response).to render_template :edit
        end
      end

      context "resource not found" do
        it do
          get :edit, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        it "assigns @user" do
          expect(assigns(:user)).to eq assigns(:user)
        end

        let(:new_attributes) do
          FactoryBot.attributes_for :user, name: "name changed"
        end

        it do
          patch :update, params: {id: user, user: new_attributes}
          user.reload
          expect(user.name).to eq new_attributes[:name]
        end

        it do
          patch :update, params: {id: user, user: new_attributes}
          expect(response).to redirect_to user
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: user, user: invalid_attributes}
          expect(response).to render_template :edit
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do
      context "resource exist" do
        it "assigns @user" do
          expect(assigns(:user)).to eq assigns(:user)
        end

        it do
          user = User.create! valid_attributes
          delete :destroy, params: {id: user}
          expect(response).to redirect_to root_path
        end
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  context "user is member" do
    before do
      member = FactoryBot.create :user, role: Settings.role.member.to_i
      @current_user = member
      log_in member
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #new" do
      it "assigns @user" do
        expect(assigns(:user)).to eq assigns(:user)
      end

      it do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {user: valid_attributes}
          }.to change(User, :count).by 1
        end

        it do
          post :create, params: {user: valid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {user: invalid_attributes}
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      context "resource exist" do
        it do
          get :edit, params: {id: user}
          expect(response).to render_template :edit
        end
      end

      context "resource not found" do
        it do
          get :edit, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        it "assigns @user" do
          expect(assigns(:user)).to eq assigns(:user)
        end

        let(:new_attributes) do
          FactoryBot.attributes_for :user, name: "name changed"
        end

        it do
          patch :update, params: {id: user, user: new_attributes}
          user.reload
          expect(user.name).to eq new_attributes[:name]
        end

        it do
          patch :update, params: {id: user, user: new_attributes}
          expect(response).to redirect_to user
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: user, user: invalid_attributes}
          expect(response).to render_template :edit
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do
      context "resource exist" do
        it "assigns @user" do
          expect(assigns(:user)).to eq assigns(:user)
        end

        it do
          user = User.create! valid_attributes
          delete :destroy, params: {id: user}
          expect(response).to redirect_to root_path
        end
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: -1}
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
