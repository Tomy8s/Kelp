require"rails_helper"

feature "Reviews" do

  scenario "Leave a review" do
    visit_my_restaurant
    click_link "Review"
    fill_in "comments", with: "Pretty average place. Needs improvement"
    fill_in "rating", with: "2"
    click_button "Review"
    expect(page).to have_content "Pretty average place. Needs improvement"
    expect(page).to have_content "Rated 2/5"
  end

end
