require 'spec_helper'
describe Search do
  before(:each) do
    @search=new Search;
  end

  it "should find one topic add topic" do		
    @search.get_topics('dd', 0, 1, 'year').find(:first).name.should eql('Проверка add topic') ;
  end
  it "should find three topics" do		
    @search.get_topics('d', 1, 0, 'year').count.should eql(3) ;
  end
end
