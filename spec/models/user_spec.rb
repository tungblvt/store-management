require "rails_helper"

RSpec.describe User, type: :model do
  subject {FactoryBot.create :user}

  describe ".create" do
    it {is_expected.to be_valid}
  end

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:email).of_type :string}
    it {is_expected.to have_db_column(:address).of_type :string}
    it {is_expected.to have_db_column(:phone).of_type :string}
    it {is_expected.to have_db_column(:avatar).of_type :string}
    it {is_expected.to have_db_column(:role).of_type :integer}
  end

  context "validations" do
    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of(:name).is_at_most Settings.validates.name.name_max}
    end

    describe "#email" do
      it {is_expected.to validate_presence_of :email}
      it {is_expected.to validate_length_of(:email).is_at_most Settings.validates.email.length}
      it {is_expected.to allow_value("project1@gmail.com").for :email}
      it {is_expected.not_to allow_value("project").for :email}
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end

    describe "#password" do
      it {is_expected.to have_secure_password}
      it {is_expected.to validate_length_of(:password).is_at_least Settings.validates.password.length.minimum}
    end
  end

  context "associations" do
    it {is_expected.to have_many :stores}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :orders}
  end

  context ".new_token" do
    let(:token_a) {User.new_token}
    let(:token_b) {User.new_token}

    it {expect(token_a).not_to eq(token_b)}
  end

  context "#remember" do
    it {expect {subject.remember}.to change(subject, :remember_digest).from(nil).to(String)}
  end

  context "#forget" do
    it {
      subject.remember_token = "$2a$10$R6mLnAso.u/r//wBa8sONei.OahOW0VEBX3PbGxDbflonOsNXvzqe"
      expect {subject.forget}.to change(subject, :remember_token)
        .from("$2a$10$R6mLnAso.u/r//wBa8sONei.OahOW0VEBX3PbGxDbflonOsNXvzqe").to(nil)
    }
  end

  context "#is_admin?" do
    it {
      subject.role = 0
      expect(subject.is_admin?).to be_truthy
    }
  end

  context "#is_manager?" do
    it {
      subject.role = 1
      expect(subject.is_manager?).to be_truthy
    }
  end
end
