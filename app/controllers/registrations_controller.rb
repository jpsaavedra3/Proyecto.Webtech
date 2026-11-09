class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  # Every new account is a member: the role is not a permitted parameter.
  def create
    @user = User.new(params.expect(user: [ :name, :email_address, :password, :password_confirmation ]))
    if @user.save
      start_new_session_for @user
      redirect_to root_path, notice: "Welcome to Roomies, #{@user.name}!"
    else
      render :new, status: :unprocessable_entity
    end
  end
end
