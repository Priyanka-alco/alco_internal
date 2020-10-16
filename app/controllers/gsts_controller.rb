class GstsController < ApplicationController
  before_action :set_gst, only: [:show, :edit, :update, :destroy]

  # GET /gsts
  # GET /gsts.json
  def index
    @gsts = Gst.all
  end

  # GET /gsts/1
  # GET /gsts/1.json
  def show
  end

  # GET /gsts/new
  def new
    @gst = Gst.new
  end

  # GET /gsts/1/edit
  def edit
  end

  # POST /gsts
  # POST /gsts.json
  def create
    @gst = Gst.new(gst_params)

    respond_to do |format|
      if @gst.save
        format.html { redirect_to @gst, notice: 'Gst was successfully created.' }
        format.json { render :show, status: :created, location: @gst }
      else
        format.html { render :new }
        format.json { render json: @gst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gsts/1
  # PATCH/PUT /gsts/1.json
  def update
    respond_to do |format|
      if @gst.update(gst_params)
        format.html { redirect_to @gst, notice: 'Gst was successfully updated.' }
        format.json { render :show, status: :ok, location: @gst }
      else
        format.html { render :edit }
        format.json { render json: @gst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gsts/1
  # DELETE /gsts/1.json
  def destroy
    @gst.destroy
    respond_to do |format|
      format.html { redirect_to gsts_url, notice: 'Gst was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gst
      @gst = Gst.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gst_params
      params.require(:gst).permit(:gst_percentage, :category, :status)
    end
end
