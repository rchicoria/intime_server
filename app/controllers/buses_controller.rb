class BusesController < ApplicationController

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  # before_filter do
  #   authenticate_user! rescue redirect_to new_user_session_path
  # end

  # GET /buses
  # GET /buses.json
  def index
    @buses = Bus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buses }
    end
  end

  # GET /buses/1
  # GET /buses/1.json
  def show
    @bus = Bus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bus.stop_positions.map {|u| [u.bus_stop.id, u.bus_stop.name, u.bus_stop.lat, u.bus_stop.lon]} }
    end
  end

  # GET /buses/new
  # GET /buses/new.json
  def new
    @bus = Bus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bus }
    end
  end

  # GET /buses/1/edit
  def edit
    @bus = Bus.find(params[:id])
  end

  # POST /buses
  # POST /buses.json
  def create
    puts params.inspect
    @bus = Bus.new(params[:bus])

    params[:stops].split(',').each do |s|
      t = StopPosition.new
      t.bus_stop_id = s.to_i
      @bus.stop_positions << t[0:-1]
    end

    respond_to do |format|
      if @bus.save
        format.html { redirect_to @bus, notice: 'Bus was successfully created.' }
        format.json { render json: @bus, status: :created, location: @bus }
      else
        format.html { render action: "new" }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buses/1
  # PUT /buses/1.json
  def update
    @bus = Bus.find(params[:id])

    respond_to do |format|
      if @bus.update_attributes(params[:bus])
        format.html { redirect_to @bus, notice: 'Bus was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buses/1
  # DELETE /buses/1.json
  def destroy
    @bus = Bus.find(params[:id])
    @bus.destroy

    respond_to do |format|
      format.html { redirect_to buses_url }
      format.json { head :ok }
    end
  end
end
