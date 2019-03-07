require 'rails_helper'

describe "Deleting a review" do 
  it "destroys the review and shows the movie listing without the review" do
    movie = Movie.create(movie_attributes(title: "Iron Man"))

    roger = User.create!(user_attributes(name: "Roger Ebert", email: "roger@example.com"))
    gene = User.create!(user_attributes(name: "Gene Siskel", email: "gene@example.com"))

    review = movie.reviews.create!(review_attributes(user: roger))

    sign_in(gene)

    visit movie_reviews_url(movie)
    
    expect(page).to have_text(roger.name)
    
    click_link "review_#{review.id}_delete"
    
    expect(current_path).to eq(movie_reviews_path(movie))   
    
    expect(page).to have_text("Review successfully deleted!")
    expect(page).not_to have_text(roger.name)
  end
end
