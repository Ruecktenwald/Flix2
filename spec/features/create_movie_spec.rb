require 'rails_helper'

describe "Creating a new movie" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)

    @genre1 = Genre.create!(name: "Genre 1")
    @genre2 = Genre.create!(name: "Genre 2")
    @genre3 = Genre.create!(name: "Genre 3")
  end

  it "saves the movie and shows the new movie's details" do
    visit movies_url

    click_link 'Add New Movie'

    expect(current_path).to eq(new_movie_path)

    fill_in "Title", with: "New Movie Title"
    fill_in "Description", with: "Superheroes saving the world from villains"
    select "PG-13", from: "movie_rating"
    fill_in "Total gross", with: "75000000"
    select (Time.now.year - 1).to_s, from: "movie_released_on_1i"
    fill_in "Cast", with: "The award-winning cast"
    fill_in "Director", with: "The ever-creative director"
    fill_in "Duration", with: "123 min"
    fill_in "Image file name", with: "movie.png"
    
    # If you're taking advantage of the HTML 5 date field in Chrome,
    # you'll need to use 'fill_in' rather than 'select'
    # fill_in "Released on", with: (Time.now.year - 1).to_s

    check(@genre1.name)
    check(@genre2.name)

    click_button 'Create Movie'

    expect(current_path).to eq(movie_path(Movie.last))

    expect(page).to have_text('New Movie Title')
    expect(page).to have_text('Movie successfully created!')
    expect(page).to have_text(@genre1.name)
    expect(page).to have_text(@genre2.name)
    expect(page).not_to have_text(@genre3.name)
  end

  it "does not save the movie if it's invalid" do
    visit new_movie_url
    
    expect { 
      click_button 'Create Movie' 
    }.not_to change(Movie, :count)
    
    expect(current_path).to eq(movies_path)   
    expect(page).to have_text('error')
  end
  it "generates a slug when it's created" do
  movie = Movie.create!(movie_attributes(title: "X-Men: The Last Stand"))

  expect(movie.slug).to eq("x-men-the-last-stand")
end

it "requires a unique title" do
  movie1 = Movie.create!(movie_attributes)

  movie2 = Movie.new(title: movie1.title)
  movie2.valid? # populates errors
  expect(movie2.errors[:title].first).to eq("has already been taken")
end

it "requires a unique slug" do
  movie1 = Movie.create!(movie_attributes)

  movie2 = Movie.new(slug: movie1.slug)
  movie2.valid? # populates errors
  expect(movie2.errors[:slug].first).to eq("has already been taken")
end
end
