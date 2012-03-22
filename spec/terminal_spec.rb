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
    @term.scan_price('A',"$2.00 or 4 for $7.00")
    @term.price('A').eql?("$2.00 or 4 for $7.00").should == true
  end
  it "should return a total of 2.00 for a cart of 1 A" do
    @term.scan_price('A',"2.00 or 4 for $7.00")
    @term.scan('A')
    @term.total.should == 2.00
  end
  it "should return a total of 7.00 for a cart of 4 A's" do
    @term.scan_price('A',"2.00 or 4 for $7.00")
    4.times { @term.scan('A')}
    @term.total.should == 7.00
  end
  it "should return a total of 9.00 for a cart of 5 A's" do
    @term.scan_price('A',"2.00 or 4 for $7.00")
    5.times { @term.scan('A')}
    @term.total.should == 9.00
  end
  it "should return a total of 14.00 for a cart of 8 A's" do
    @term.scan_price('A',"2.00 or 4 for $7.00")
    8.times { @term.scan('A')}
    @term.total.should == 14.00
  end
  it "should return a total of 6.00 for a cart of 3 A's" do
    @term.scan_price('A',"2.00 or 4 for $7.00")
    3.times { @term.scan('A')}
    @term.total.should == 6.00
  end
  it "should return a total of 1.25 for a cart of 1 B" do
    @term.scan_price('B',"$1.25 or $6 for a six pack")
    @term.scan('B')
    @term.total.should == 1.25
  end
  it "should return a price of 6.00 for a six pack of B" do
    @term.scan_price('B',"$1.25 or $6 for a six pack")
    6.times{ @term.scan('B')}
    @term.total.should == 6.00
  end
end
