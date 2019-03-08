class AddSlugToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :slug, :string
  end
end
