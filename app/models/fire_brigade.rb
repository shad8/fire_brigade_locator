class FireBrigade < ApplicationRecord
  geocoded_by :address

  def address
    [street, city].compact.join(', ')
  end
end
