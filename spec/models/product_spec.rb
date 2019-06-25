require "rails_helper"

RSpec.describe Product, type: :model do
  let(:user) {FactoryBot.create :user }
  let(:store) {FactoryBot.create :store, user_id: user.id }
  let(:category) {FactoryBot.create :category, store_id: store.id}
  subject {FactoryBot.create :product, category_id: category.id}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:description).of_type :text}
    it {is_expected.to have_db_column(:price).of_type :string}
    it {is_expected.to have_db_column(:image).of_type :string}
    it {is_expected.to have_db_column(:status).of_type :integer}
    it {is_expected.to have_db_column(:is_deleted).of_type :boolean}
  end

  context "validations" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_most Settings.validates.name.name_max}
    end

    describe "#price" do
      it {is_expected.to validate_presence_of :price}
      it {is_expected.to allow_value("123000").for :price}
      it {is_expected.not_to allow_value("123abc").for :price}
    end
  end

  context "associations" do
    it {is_expected.to have_many :order_details}
    it {is_expected.to belong_to :category}
  end
end
