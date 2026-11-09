class ProfilesController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(params.expect(user: [ :name, :email_address, :phone, :bio ]))
      redirect_to edit_profile_path, notice: "Your profile was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
    authorize @user
  end
end
