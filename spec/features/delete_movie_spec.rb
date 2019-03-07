require 'rails_helper'

describe "Deleting a movie" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end
  
  it "destroys the movie and shows the movie listing without the deleted movie" do
    movie = Movie.create!(movie_attributes)

    visit movie_path(movie)

    click_link 'Delete'

    expect(current_path).to eq(movies_path)
    expect(page).not_to have_text(movie.title)
    expect(page).to have_text("Movie successfully deleted!")
  end
end
