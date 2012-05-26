class TravelsController < ApplicationController
  # GET /travels
  # GET /travels.json
  def index
    @travels = Travel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @travels }
    end
  end

  # GET /travels/1
  # GET /travels/1.json
  def show
    @travel = Travel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @travel }
    end
  end

  # GET /travels/new
  # GET /travels/new.json
  def new
    @travel = Travel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @travel }
    end
  end

  # GET /travels/1/edit
  def edit
    @travel = Travel.find(params[:id])
  end

  # POST /travels
  # POST /travels.json
  def create
    @travel = Travel.new(params[:travel])

    respond_to do |format|
      if @travel.save
        format.html { redirect_to @travel, notice: 'Travel was successfully created.' }
        format.json { render json: @travel, status: :created, location: @travel }
      else
        format.html { render action: "new" }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /travels/1
  # PUT /travels/1.json
  def update
    @travel = Travel.find(params[:id])

    respond_to do |format|
      if @travel.update_attributes(params[:travel])
        format.html { redirect_to @travel, notice: 'Travel was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travels/1
  # DELETE /travels/1.json
  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy

    respond_to do |format|
      format.html { redirect_to travels_url }
      format.json { head :ok }
    end
  end
end
