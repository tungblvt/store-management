require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) {FactoryBot.create :user }
  let(:store) {FactoryBot.create :store, user_id: user.id}
  subject {FactoryBot.create :comment, user_id: user.id, store_id: store.id}

  context "database" do
    it {is_expected.to have_db_column(:content).of_type :text}
    it {is_expected.to have_db_column(:rate).of_type :integer}
  end

  context "validate" do
    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#content" do
      it {is_expected.to validate_presence_of :content}
    end
  end

  context "association" do
    describe "belong_to_user_and_store" do
      it {is_expected.to belong_to :user}
      it {is_expected.to belong_to :store}
    end
  end
end
