require "rails_helper"

RSpec.describe Store, type: :model do
  let(:user) {FactoryBot.create :user }
  subject {FactoryBot.create :store, user_id: user.id}

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:short_description).of_type :string}
    it {is_expected.to have_db_column(:description).of_type :text}
    it {is_expected.to have_db_column(:address).of_type :string}
    it {is_expected.to have_db_column(:status).of_type :integer}
    it {is_expected.to have_db_column(:image).of_type :string}
    it {is_expected.to have_db_column(:is_lock).of_type :boolean}
  end

  context "validate" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
    end

    describe "#address" do
      it {is_expected.to validate_presence_of :address}
    end

    describe "#short_description" do
      it {is_expected.to validate_presence_of :short_description}
      it {is_expected.to validate_length_of(:short_description).is_at_most Settings.validates.store.short_description_max}
    end
  end

  describe ".lock_store" do
    it {
      subject.lock_store
      expect(subject.reload.is_lock).to eq(true)
    }
  end

  describe ".unlock_store" do
    it {
      subject.unlock_store
      expect(subject.reload.is_lock).to eq(false)
    }
  end

  context "association" do
    describe "has_many_categories" do
      it {is_expected.to have_many :categories}
    end
  end
end
