class TripCost
  attr_reader :night_fees, :fee_to_night_counts  

  def initialize(listing, check_in_date, check_out_date)
    @service_fee_cents = Listing.service_fee_cents
    @night_fees = []
    @fee_to_night_counts = Hash.new(0)

    provisions = ListingProvision.by_listing(listing)

    check_in_date.step(check_out_date - 1) do |date|
      provision = provisions.for_date(date)
      @cleaning_fee_cents = provision.cleaning_fee_cents if date == check_in_date  
      @night_fees << Money.new(provision.nightly_fee_cents)
      @fee_to_night_counts[provision.nightly_fee_cents] += 1 
    end
  end

  def total_nights_cents
    @fee_to_night_counts.each_pair.map{ |fee, count| fee * count }.reduce(0, :+)
  end

  def total_cents
    @service_fee_cents + @cleaning_fee_cents + total_nights_cents
  end

  def cleaning_fee
    Money.new(@cleaning_fee_cents)
  end

  def service_fee
    Money.new(@service_fee_cents)
  end

  def total
    Money.new(total_cents)
  end
end