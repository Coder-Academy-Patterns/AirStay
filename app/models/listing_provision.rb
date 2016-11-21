class ListingProvision < ApplicationRecord
  belongs_to :listing

  default_scope -> { order(start_date: :asc) }

  scope :by_listing, -> (listing) { where(listing: listing) }
  scope :starting_from, -> (date) { where('start_date <= ?', date).order(start_date: :asc) }

  def self.for_date(date)
    starting_from(date).limit(1).first
  end

  monetize :nightly_fee_cents
  monetize :cleaning_fee_cents
end

# class ListingProvision
#   def self.route_key
#     'provisions'
#   end

#   def self.singular_route_key
#     'provision'
#   end

#   def model_name
#     ActiveModel::Name.new(
#       self.class,
#       nil,
#       'provision'
#     )
#   end
# end
