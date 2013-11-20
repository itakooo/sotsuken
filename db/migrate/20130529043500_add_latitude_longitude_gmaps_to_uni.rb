class AddLatitudeLongitudeGmapsToUni < ActiveRecord::Migration
  def change
    add_column :unis, :latitude, :float

    add_column :unis, :longitude, :float

    add_column :unis, :gmaps, :boolean

  end
end
