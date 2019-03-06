require 'rails_helper'

describe "Deleting a review" do 
  it "destroys the review and shows the movie listing without the review" do
    movie = Movie.create(movie_attributes(title: "Iron Man"))
    
    visit movie_reviews_url(movie)
    
    
    click_link "review_#{review1.id}_delete"
    
    expect(current_path).to eq(movie_reviews_path(movie))   
    
    expect(page).to have_text("Review successfully deleted!")

  end
end
