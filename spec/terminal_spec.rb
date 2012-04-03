require 'spec_helper'

describe "Terminal" do
  before (:each) do
    @term = Terminal.new
    prices = [['A',"$2.00 or 4 for $7.00"],['C',"$1.25 or $6 for a six pack"],['B', "$12.00"],['D', "$0.15"]]
    @term.set_pricing(prices)
  end
  it "Terminal should recieve a set_pricing method" do
    Terminal.instance_methods.include?(:set_pricing).should == true
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
    @term.price('A').eql?("$2.00 or 4 for $7.00").should == true
  end
  it "should return a total of 2.00 for a cart of 1 A" do
    @term.scan('A')
    @term.total.should == 2.00
  end
  it "should return a total of 7.00 for a cart of 4 A's" do
    4.times { @term.scan('A')}
    @term.total.should == 7.00
  end
  it "should return a total of 9.00 for a cart of 5 A's" do
    5.times { @term.scan('A')}
    @term.total.should == 9.00
  end
  it "should return a total of 14.00 for a cart of 8 A's" do
    8.times { @term.scan('A')}
    @term.total.should == 14.00
  end
  it "should return a total of 6.00 for a cart of 3 A's" do
    3.times { @term.scan('A')}
    @term.total.should == 6.00
  end
  it "should return a total of 1.25 for a cart of 1 C" do
    @term.scan('C')
    @term.total.should == 1.25
  end
  it "should return a price of 6.00 for a six pack of C" do
    6.times{ @term.scan('C')}
    @term.total.should == 6.00
  end
  it "should return a total of 12.00 for a cart of 1 B" do
    @term.scan('B')
    @term.total.should == 12.00
  end
  it "should return a total of 0.15 for a cart of 1 D" do
    @term.scan('D')
    @term.total.should == 0.15
  end
  context "test the given examples" do
    before (:each) do
      prices = [['A',"$2.00 or 4 for $7.00"],['C',"$1.25 or $6 for a six pack"],['B', "$12.00"],['D', "$0.15"]]
      @term = Terminal.new
      @term.set_pricing(prices)
    end

    it "should return a price of 32.40 for ABCDABAA" do
      "ABCDABAA".chars.to_a.each{ |a| @term.scan(a)}
      @term.total.should == 32.40
    end
    it "should return a price of 7.25 for CCCCCCC" do
      "CCCCCCC".chars.to_a.each{ |a| @term.scan(a)}
      @term.total.should == 7.25
    end
    it "should return a price of 15.40 for ABCD" do
      "ABCD".chars.to_a.each{ |a| @term.scan(a)}
      @term.total.should == 15.40
    end
  end
end
