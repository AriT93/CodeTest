require 'spec_helper'

describe "Terminal" do
  before (:each) do
    @term = Terminal.new
  end
  it "Terminal should recieve a scan_price method" do
    Terminal.instance_methods.include?(:scan_price).should == true
  end
  it "Terminal should recieve a scan method" do
    Terminal.instance_methods.include?(:scan).should == true
  end
  it "Terminal should recieve a total method" do
    Terminal.instance_methods.include?(:total).should == true
  end
  it "Terminal should recieve a price method" do
    Terminal.instance_methods.include?(:price).should == true
  end
  it "Terminal should return the price of an object" do
    @term.scan_price('A',"$1.25 or 4 for $7.00")
    @term.price('A').eql?("$1.25 or 4 for $7.00").should == true
  end
  it "should return a total of 1.25 for a cart of 1 A" do
    @term.scan_price('A',"1.25 or 4 for $7.00")
    @term.scan('A')
    @term.total.should == 1.25
  end
end
