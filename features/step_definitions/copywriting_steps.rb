Given /^I have no copywritings$/ do
  Refinery::CopywritingPhrase.delete_all
end

Given /^I (only )?have copywritings titled "?([^\"]*)"?$/ do |only, titles|
  Refinery::CopywritingPhrase.delete_all if only
  titles.split(', ').each do |title|
    Refinery::CopywritingPhrase.create(:name => title)
  end
end

Then /^I should have ([0-9]+) copywritings?$/ do |count|
  Refinery::CopywritingPhrase.count.should == count.to_i
end
