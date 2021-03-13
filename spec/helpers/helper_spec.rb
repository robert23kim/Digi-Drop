require 'rails_helper'

describe MoviesHelper do
  describe 'check oddness' do
    it "returns odd" do
      expect(oddness(3).should eq("odd"))
    end
  end
end