class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  autocomplete :user, :event

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def last
    @lastusers = User.all.sort_by{ |result| result.updated_at}.reverse

  end

  def events
    @events = Event.all.sort_by{ |result| result.date}.reverse
  end


  def event
    @event = Event.find(params[:id])
    @users = @event.users

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{@event.name}.csv" }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def success
    @gif = ["http://i.giphy.com/TEFplLVRDMWBi.gif",
            "http://i.giphy.com/WKhKazqZxORq0.gif",
            "http://i.giphy.com/1HPzxMBCTvjMs.gif",
            "http://i.giphy.com/9o67upvAnOqRy.gif",
            "http://i.giphy.com/JQNM4AgN7lFUA.gif",
            "http://i.giphy.com/vQ9JbgIWATcTS.gif",
            "http://i.giphy.com/gdNlcJ1tAtiSI.gif",
            "http://i.giphy.com/rgS5azacQACw8.gif"]
  end


  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
    @event = Event.last.name.split("-").first
  end

  # GET /users/1/edit
  def edit
  end




  # POST /users
  # POST /users.json
  def create

    require 'clearbit'

    Clearbit.key = ENV["clearbit_gmail"]

    @user = User.where(email: user_params[:email]).first_or_initialize
    result = Clearbit::Enrichment.find(email: @user.email, stream: true)

    respond_to do |format|
      if @user.update(user_params)
        @user.events << Event.last unless @user.events.include?(Event.last)
        unless result.person.nil?
          @user.update_attributes(avatar: result.person.avatar, bio: result.person.bio, employment_name: result.person.employment.name,
                                    twitter_handle: result.person.twitter.handle, linkedin_handle: result.person.linkedin.handle,
                                    employment_domain: result.person.employment.domain, fuzzy: result.person.fuzzy)
        end
        first_name = @user.name.split(" ").first
        last_name = @user.name.split(" ").last
        @user.update_attributes(first_name: first_name, last_name: last_name)

        format.html { redirect_to success_path }
      else
        format.html { render :new }
      end
    end
  end



  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :note, :event, :interest, :company, :avatar, :bio)
    end
end
