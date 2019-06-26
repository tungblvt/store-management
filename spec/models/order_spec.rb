require "rails_helper"

RSpec.describe Order, type: :model do
  let(:user_manager) {FactoryBot.create :user, role: Settings.role.manager.to_i}
  let(:user_order) {FactoryBot.create :user, role: Settings.role.member.to_i }
  let(:store) {FactoryBot.create :store, user_id: user_manager.id }
  subject {FactoryBot.create :order, user_id: user_order.id, store_id: store.id}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:address).of_type :string}
    it {is_expected.to have_db_column(:status).of_type :integer}
    it {is_expected.to have_db_column(:shipped_date).of_type :datetime}
    it {is_expected.to have_db_column(:subtotal).of_type :string}
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :store}
  end
end
