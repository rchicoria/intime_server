class BusStopsController < ApplicationController
  # GET /bus_stops
  # GET /bus_stops.json

  # before_filter do
  #   authenticate_user! rescue redirect_to new_user_session_path
  # end

  def index
    @bus_stops = BusStop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bus_stops }
    end
  end

  # GET /bus_stops/1
  # GET /bus_stops/1.json
  def show
    @bus_stop = BusStop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bus_stop }
    end
  end

  # GET /bus_stops/new
  # GET /bus_stops/new.json
  def new
    @bus_stop = BusStop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bus_stop }
    end
  end

  # GET /bus_stops/1/edit
  def edit
    @bus_stop = BusStop.find(params[:id])
  end

  # POST /bus_stops
  # POST /bus_stops.json
  def create
    @bus_stop = BusStop.new(params[:bus_stop])

    respond_to do |format|
      if @bus_stop.save
        format.html { redirect_to @bus_stop, notice: 'Bus stop was successfully created.' }
        format.json { render json: @bus_stop, status: :created, location: @bus_stop }
      else
        format.html { render action: "new" }
        format.json { render json: @bus_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bus_stops/1
  # PUT /bus_stops/1.json
  def update
    if params[:id]
      @bus_stop = BusStop.find(params[:id])
    else
      @bus_stop = BusStop.find_by_name(params[:find_name])
    end
    respond_to do |format|
      if @bus_stop.update_attributes(params[:bus_stop])
        format.html { redirect_to @bus_stop, notice: 'Bus stop was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bus_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bus_stops/1
  # DELETE /bus_stops/1.json
  def destroy
    if params[:id]
      @bus_stop = BusStop.find(params[:id])
    else
      @bus_stop = BusStop.find_by_name(params[:find_name])
    end
    @bus_stop.destroy

    respond_to do |format|
      format.html { redirect_to bus_stops_url }
      format.json { head :ok }
    end
  end

  def get_by_coordinates
    lat = params[:lat]
    lon = params[:lon]
    @bus_stops = BusStop.where('lat >= (? - 0.0005) and lat <= (? + 0.0005) and lon >= (? - 0.0005) and lon <= (? + 0.0005)', lat, lat, lon, lon)
    value = []
    @bus_stops.each do |bus_stop|
      buses = []
      t = {}
      t["name"] = bus_stop.name
      StopPosition.where('bus_stop_id = ?', bus_stop.id).each do |stop_position|
        bmap = {}
        bmap["id"] = stop_position.bus.id
        bmap["name"] = stop_position.bus.name
        buses << bmap
      end
      t["buses"] = buses
      value << t
    end
    respond_to do |format|
      format.json { render json: value }
    end
  end
end
