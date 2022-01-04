# frozen_string_literal: true

RSpec.describe Autotune do
  it "has a version number" do
    expect(Autotune::VERSION).not_to be nil
  end

  describe "#go_with"
  it "does something useful" do
    expect(Autotune.go_with([2,0,1]) {|a| pp a ; sleep(a) } ).to eq 0
    expect(Autotune.go_with([0,1,2], [0,1]) {|a,b| sleep(a+b) } ).to eq [0,0]
    expect(Autotune.go_with([0,1,2], [0,1],[0,1] ,[0,1,1]) {|a,b,c,d| sleep(a+b+c+d)  } ).to eq [0,0,0,0]
  end
end
