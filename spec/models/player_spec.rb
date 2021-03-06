require 'rails_helper'

RSpec.describe Player, type: :model do
  it {should validate_uniqueness_of(:nbacomid).case_insensitive}
  it {should validate_presence_of(:fname)}
  it {should validate_presence_of(:lname)}
  it {should validate_presence_of(:birthdate)}
  it {should validate_presence_of(:school)}
  it {should validate_presence_of(:country)}
  it {should validate_presence_of(:height)}
  it {should validate_numericality_of(:height).only_integer}
  it {should validate_numericality_of(:rookie_year).only_integer}

  context "With all the information filled out" do
    before do
      VCR.use_cassette("Get Player") do
        Player.checkplayer(2404)
      end
    end

    after do
      VCR.eject_cassette
    end

    scenario "One record is added to the blank database" do  
      expect(Player.count).to eq(1)
    end

    scenario "The proper information is added to the proper fields" do
      expect(Player.first.fname).to eq("Chris")
      expect(Player.first.lname).to eq("Wilcox")
      expect(Player.first.school).to eq("Maryland")
      expect(Player.first.height).to eq(82)
      expect(Player.first.country).to eq("USA")
      expect(Player.first.rookie_year).to eq(2002)
    end
  end

  context "Testing methoods on the player model" do

    before { system 'psql -d nba_test -f spec/dumps/query_data_source.sql' }

    scenario "Finding the leaderboard qualified players works" do
      expect(Player.qualified.length).to eq 210
    end
  end
end