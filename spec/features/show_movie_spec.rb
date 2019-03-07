require 'rails_helper'

describe "Viewing an individual movie" do

  it "shows the movie's details" do
    movie = Movie.create!(movie_attributes(total_gross: 300000000.00))

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text("$300,000,000.00")
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
  end

  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create!(movie_attributes(total_gross: 60000000.00))
    
    visit movie_url(movie)
    
    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create!(movie_attributes(total_gross: 40000000.00))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end

  it "shows the movie's fans and genres in the sidebar" do
    movie = Movie.create!(movie_attributes)

    user = User.create!(user_attributes)
    movie.fans << user

    genre = Genre.create!(name: "Action")
    movie.genres << genre

    visit movie_url(movie)

    within("aside#sidebar") do
      expect(page).to have_text(user.name)
      expect(page).to have_text(genre.name)
    end
  end

  it "includes the movie's title in the page title" do
    movie = Movie.create!(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_title("Flix - #{movie.title}")
  end

end
