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

    # params[:stops].split(',').each do |s|
    #   t = StopPosition.new
    #   t.bus_stop_id = s.to_i
    #   t.save
    #   for hour in (0..23)
    #     Day.all.each do |day|
    #       delay = Delay.new(stop_position_id: t.id, day_id: day.id, this_hour: hour, minutes_delayed: 0, precision: 0)
    #     end
    #   end
    #   @bus.stop_positions << t
    # end

    respond_to do |format|
      if @bus.save
        params[:stops].split(',').each do |s|
          t = StopPosition.new(bus_stop_id: s.to_i, bus_id: @bus.id)
          t.save
          for hour in (0..23)
            Day.all.each do |day|
              delay = Delay.create(stop_position_id: t.id, day_id: day.id, this_hour: hour, minutes_delayed: 0, precision: 0)
              delay.save
            end
          end
        end
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

  # Check in
  def check_in
    bus = Bus.find(params[:bus_id])
    bus_stop = BusStop.find(params[:bus_stop_id])
    value = []
    t = {}
    t["id"] = bus.id
    t["name"] = bus.name
    t["bus_stops"] = []
    StopPosition.where('bus_id = ?', bus.id).each do |stop_position|
      bmap = {}
      bmap["id"] = stop_position.bus_stop.id
      bmap["name"] = stop_position.bus_stop.name
      bmap["lat"] = stop_position.bus_stop.lat
      bmap["lon"] = stop_position.bus_stop.lon
      t["bus_stops"] << bmap if t["bus_stops"].index(bmap).nil?
    end
    # while t["bus_stops"].first["id"] != bus_stop.id
    #   t["bus_stops"] << t["bus_stops"].delete_at(0)
    # end
    # t["bus_stops"] << t["bus_stops"].delete_at(0)
    value << t
    respond_to do |format|
      format.json { render json: value }
    end
  end
end
