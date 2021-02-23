class AddCoordinatesToMotels < ActiveRecord::Migration[6.0]
  def change
    add_column :motels, :coordinates, :spatial, srid: 4326, type: :point, geographic: true
  end
end
