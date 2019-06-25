require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  let(:user_manager) {FactoryBot.create :user, role: Settings.role.manager.to_i }
  let(:user_member) {FactoryBot.create :user, role: Settings.role.member.to_i }
  let(:store) {FactoryBot.create :store, user_id: user_manager.id}
  let(:category) {FactoryBot.create :category, store_id: store.id}
  let(:product) {FactoryBot.create :product, category_id: category.id}
  let(:order) {FactoryBot.create :order, user_id: user_member.id, store_id: store.id}
  subject {FactoryBot.create :order_detail, order_id: order.id, product_id: product.id}

  context "database" do
    it {is_expected.to have_db_column(:quantity).of_type :integer}
    it {is_expected.to have_db_column(:price).of_type :string}
    it {is_expected.to have_db_column(:total).of_type :string}
  end

  context "validate" do
    describe ".create" do
      it {is_expected.to be_valid}
    end
  end

  context "association" do
    describe "belong_to_order_and_product" do
      it {is_expected.to belong_to :order}
      it {is_expected.to belong_to :product}
    end
  end
end
