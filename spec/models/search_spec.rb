require 'spec_helper'
describe Search do
  before(:each) do
    @search=Search.new;
  end

  it "should find one topic with First" do
    @search.get_topics('First', 0, 1, 'year').length.should eql(1) ;
    #@search.get_topics('First', 0, 1, 'year').find(:first).name.should eql('First Topic') ;
  end
  it "should find one topic" do		
    @search.get_topics('o', 1, 0, 'year').size.should eql(1) ;
  end
end
