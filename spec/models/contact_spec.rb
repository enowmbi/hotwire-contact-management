require 'rails_helper'

RSpec.describe Contact, type: :model do
  after(:all) { User.destroy_all }

  describe "attributes" do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end
  describe "indexes" do
    it { is_expected.to have_db_index(:name).unique }
    it { is_expected.to have_db_index(:email).unique }
    it { is_expected.to have_db_index([:name, :email]).unique }
  end
  describe "validation" do
    user = FactoryBot.create(:user)
    FactoryBot.create(:contact, user: user)

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:user_id).ignoring_case_sensitivity }
  end
end
