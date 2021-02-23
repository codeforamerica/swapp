class Motel < ApplicationRecord
  after_save :geocode_address, if: ->(obj) { obj.address.present? and obj.address_changed? }

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end

  private 

    def geocode_address
      # 0. while you're working Ben will configure postgres for storage of lat/lng
      # configure postgis
      # create migration to add lat/lng column on motels table
      
      # 1.  # translate our JSON address field into what the mapbox geocoding sdk needs
      # (probably a string)
      
      # 2. read mapbox geocode sdk docs and figure out how to 
      # instantiate the geocoder if necessary (with API creds)
      # make the geocode call, providing our address string from step 1.

      # 3. parse geocode response
      # places = Mapbox::Geocoder.geocode_forward("Chester, NJ", {:proximity => {:longitude => -74.6968, :latitude => 40.7843}})
      
      # 4. store it 
      # {:longitude => -74.6968, :latitude => 40.7843}
      # motel.coordinates = RGeo::Geographic.spherical_factory(srid: 4326, geo_type: "point").point(coords[:latitude], coords[:longitude])
    end
end
