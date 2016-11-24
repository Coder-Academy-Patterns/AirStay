class ListingProvisionsController < ApplicationController
  before_action :set_listing
  before_action :set_listing_provision, only: [:show, :edit, :update, :destroy]

  # GET /listing_provisions
  # GET /listing_provisions.json
  def index
    @listing_provisions = ListingProvision.where(listing: @listing).oldest_to_youngest
  end

  # GET /listing_provisions/1
  # GET /listing_provisions/1.json
  def show
  end

  # GET /listing_provisions/new
  def new
    @listing_provision = ListingProvision.new
  end

  # GET /listing_provisions/1/edit
  def edit
  end

  # POST /listing_provisions
  # POST /listing_provisions.json
  def create
    @listing_provision = ListingProvision.new(listing_provision_params)
    @listing_provision.listing = @listing

    respond_to do |format|
      if @listing_provision.save
        format.html { redirect_to [@listing, @listing_provision], notice: 'Listing provision was successfully created.' }
        format.json { render :show, status: :created, location: [@listing, @listing_provision] }
      else
        format.html { render :new }
        format.json { render json: @listing_provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listing_provisions/1
  # PATCH/PUT /listing_provisions/1.json
  def update
    respond_to do |format|
      if @listing_provision.update(listing_provision_params)
        format.html { redirect_to [@listing, @listing_provision], notice: 'Listing provision was successfully updated.' }
        format.json { render :show, status: :ok, location: [@listing, @listing_provision] }
      else
        format.html { render :edit }
        format.json { render json: @listing_provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listing_provisions/1
  # DELETE /listing_provisions/1.json
  def destroy
    @listing_provision.destroy
    respond_to do |format|
      format.html { redirect_to listing_listing_provisions_url(@listing), notice: 'Listing provision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_listing_provision
      @listing_provision = ListingProvision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_provision_params
      params.require(:listing_provision).permit(:start_date, :guests_max, :bedroom_count, :bed_count, :nights_min, :nightly_fee_cents, :cleaning_fee_cents)
    end
end
