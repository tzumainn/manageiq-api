RSpec.describe Api do
  describe "::VERSION_REGEX" do
    it "detects the major version" do
      expect("v1").to be_a_valid_version
    end

    it "detects the minor version" do
      expect("v1.2").to be_a_valid_version
    end

    it "detects the patch version" do
      expect("v1.2.3").to be_a_valid_version
    end

    it "detects the prerelease version" do
      expect("v1.2.3-pre").to be_a_valid_version
      expect("v1.2.3-pre1").to be_a_valid_version
      expect("v1.2.3-pre-1").to be_a_valid_version
      expect("v1.2.3-pre.four").to be_a_valid_version
      expect("v1.2.3-alpha").to be_a_valid_version
      expect("v1.2.3-beta").to be_a_valid_version
      expect("v1.2.3-alpha.45").to be_a_valid_version
      expect("v1.2.3 pre").not_to be_a_valid_version
    end

    specify "versions must be prefixed with a 'v'" do
      expect("1.2.3").not_to be_a_valid_version
      expect("abcv1.2.3").not_to be_a_valid_version
    end

    def be_a_valid_version
      match(Api::VERSION_REGEX)
    end
  end

  describe ".compressed_id?" do
    it "returns true for a compressed id" do
      expect(Api.compressed_id?("1r1")).to be(true)
    end

    it "returns false for an uncompressed id" do
      expect(Api.compressed_id?(1_000_000_000_001)).to be(false)
      expect(Api.compressed_id?("1000000000001")).to be(false)
    end

    it "returns false for nil" do
      expect(Api.compressed_id?(nil)).to be(false)
    end
  end
end
