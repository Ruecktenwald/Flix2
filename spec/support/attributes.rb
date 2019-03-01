def movie_attributes(overrides = {})
  random_number = (0..9).to_a.shuffle[0..10].join
  {
    title: "Iron Man #{random_number}",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    released_on: "2008-05-02",
    cast: "Robert Downey Jr., Gwyneth Paltrow and Terrence Howard",
    director: "Jon Favreau",
    duration: "126 min",
    image_file_name: "ironman.jpg"
  }.merge(overrides)
end

def review_attributes(overrides = {})
  {
    name: "Roger Ebert",
    stars: 3,
    comment: "I laughed, I cried, I spilled my popcorn!"
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    name: "Example User",
    email: "user@example.com",
    password: "secret",
    password_confirmation: "secret"
  }.merge(overrides)
end
