require "rails_helper"

RSpec.describe Pokemon, :type => :model do
  subject(:pokemon) { Pokemon.new }

  describe "#valid?" do
    subject { pokemon.valid? }

    context "when name is empty" do
      before { pokemon.name = nil }
      it { is_expected.to be_falsey }
    end

    context "when name is defined" do
      before { pokemon.name = "test" }
      it { is_expected.to be_truthy }
    end
  end
end
