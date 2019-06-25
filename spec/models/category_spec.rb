require "rails_helper"

RSpec.describe Category, type: :model do
  let(:user) {FactoryBot.create :user }
  let(:store) {FactoryBot.create :store, user_id: user.id }
  subject {FactoryBot.create :category, store_id: store.id}

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:description).of_type :text}
  end

  context "validate" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
    end
  end

  context "association" do
    describe "belong_to_store" do
      it {is_expected.to belong_to :store}
    end
  end
end
