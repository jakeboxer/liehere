require 'spec_helper'

describe Statement do
  describe 'truth?' do
    it "is true for a truth statement" do
      expect(FactoryGirl.create(:truth_statement)).to be_truth
    end

    it "is false for a lie statement" do
      expect(FactoryGirl.create(:lie_statement)).not_to be_truth
    end
  end
end
