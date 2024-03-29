class RatingsController < ApplicationController
  before_action :set_rating, only: [:destroy]

  # GET /ratings
  # GET /ratings.json
  def index
    # byebug
    @ratings = Rating.all
    @event = Event.find(params[:event_id])
  end

  # POST /ratings
  # POST /ratings.json
  def create
    # Check if already exists
    if Rating.find_by(user_id: current_user.id, event_id: params[:event_id])
      update
    else
      @rating = Rating.new(rating_params)
      @rating.event_id = params[:event_id]
      @rating.user_id = current_user.id

      respond_to do |format|
        if @rating.save
          format.html { redirect_back fallback_location: root_path }
        else
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    @rating = Rating.find_by(user_id: current_user.id, event_id: params[:event_id])
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_back fallback_location: root_path }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Rating was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit("food", "drinks", "talks", "vibe")
    end
end
