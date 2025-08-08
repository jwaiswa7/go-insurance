class ClaimsController < ApplicationController
  before_action :set_claim, only: %i[ show edit update destroy ]

  # GET /claims or /claims.json
  def index
    @claims = Claim.all.order(created_at: :desc)
  end

  # GET /claims/1 or /claims/1.json
  def show
  end

  # GET /claims/new
  def new
    @claim = Claim.new
    @claim.claim_destinations.build
  end

  # GET /claims/1/edit
  def edit
    @claim.build_claim_snow if @claim.claim_snow.blank?
    @premiums = @claim.premiums
  end

  # POST /claims or /claims.json
  def create
    @claim = Claim.new(claim_params)

    destinations = params[:claim][:destinations].reject(&:blank?) # remove empty string
    destinations.each do |destination|
      @claim.claim_destinations.build(destination_id: destination)
    end

    respond_to do |format|
      if @claim.save
        Premiums::BasePremium.call(@claim)

        format.html { redirect_to edit_claim_path(@claim), notice: "Claim was successfully created." }
        format.json { render :edit, status: :created, location: @claim }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /claims/1 or /claims/1.json
  def update
    respond_to do |format|
      if @claim.update(claim_params)
        Premiums::FinalPremium.call(@claim.reload)
        @premiums = @claim.premiums

        format.html { redirect_to edit_claim_path(@claim), notice: "Claim was successfully updated." }
        format.json { render :show, status: :ok, location: @claim }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /claims/1 or /claims/1.json
  def destroy
    @claim.destroy!

    respond_to do |format|
      format.html { redirect_to claims_path, status: :see_other, notice: "Claim was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def claim_params
      params.require(:claim).permit(
        :trip_type_id, :age_id, :trip_start_date, :trip_end_date,
        :excess_id, :has_cruise, :policy, :email,
        claim_snow_attributes: [ :id, :start_date, :end_date, :_destroy ],
      )
    end
end
