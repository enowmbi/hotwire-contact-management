require 'rails_helper'

RSpec.describe Contact, type: :model do
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
  end
end
