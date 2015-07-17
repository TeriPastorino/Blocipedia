require 'spec_helper'
require 'rails_helper'

describe "Viewing wikis" do
  it "shows the list of all wikis" do
    visit wikis_path
    expect(page).to have_text("Wikis")
  end
  
  it "shows an individual wiki" do
    visit wiki_url
    expect(page).to have_text("Wikis")
  end
end
 
