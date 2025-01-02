class SettingsController < ApplicationController
  before_action :authenticate!
  # before_action :find_account, only: :update_name

  def index

  end

  def account_information
    
  end

  def password
    
  end

  def email
    
  end

  def name
    @profile = current_account.profile
  end

  def update_name
    @profile = current_account.profile

    if @profile.update(name_params)
      flash[:notice] = "Name updated successfully."
      redirect_to account_information_settings_path
    else
      flash.now[:alert] = @profile.errors.full_messages.join(", ")
      render :name, status: :unprocessable_entity
    end
  end

  private

  def name_params
    params.require(:profile).permit(:name)
  end
end
