class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where(listing: @listing).order(created_at: :asc)
    @new_message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.guest = current_user
    @message.listing = @listing

    respond_to do |format|
      if @message.save
        format.html { redirect_to listing_messages_url(@listing) }
        format.json { render :show, status: :created, location: listing_messages_url(@listing) }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:listing_id])
      # Can’t message yourself
      redirect_to @listing if @listing.host == current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content)
    end
end
