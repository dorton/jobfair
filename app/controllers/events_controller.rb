class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => :localevents



def index
  @campus = current_admin.locations.first
  if current_admin.super_admin?
    @events = Event.all
  else
    @events = Event.joins(:locations).where("locations.id = ?", @campus).all.order(:date).reverse
  end
end

def localevents
  if current_admin.super_admin?
    @location = Location.find(params[:id])
    @events = Event.joins(:locations).where("locations.id = ?", @location)
  end
end

def show
  @users = @event.users.order(:interest)

  respond_to do |format|
    format.html
    format.csv { send_data @users.to_csv, filename: "#{@event.name}.csv" }
  end
end

def new
  @event = Event.new
  @event.location = 'The Iron Yard'
  @unique = Event.pluck('DISTINCT name')
end

def create
  @event = Event.new(event_params)

  respond_to do |format|
    if @event.save
      @event.locations << current_admin.locations.first

      format.html { redirect_to @event, notice: 'event was successfully created.' }
      format.json { render :show, status: :created, location: @event }
    else
      format.html { render :new }
      format.json { render json: @event.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /events/1
# PATCH/PUT /events/1.json
def update
  respond_to do |format|
    if @event.update(event_params)
      format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      format.json { render :show, status: :ok, location: @event }
    else
      format.html { render :edit }
      format.json { render json: @event.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /events/1
# DELETE /events/1.json
def destroy
  @event.destroy
  respond_to do |format|
    format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    if current_admin.super_admin?
      @event = Event.find(params[:id])
    else
      @campus = current_admin.locations.first
      @event = Event.joins(:locations).where("locations.id = ?", @campus).find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit!
  end
end
