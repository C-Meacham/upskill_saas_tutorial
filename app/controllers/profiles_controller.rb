class ProfilesController < ApplicationController
  # GET to /users/:user_id.profile/new
  def new
    @profile = Profile.new
  end  
  def create
    # Ensure we have correct user
    @user = User.find( params[:user_id] )
    # Create profile linked to specifc user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      flash[:notice] ="Oops! Something went wrong! Please try again."
      render action: :new
    end  
  end  
  # Get requests to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end    