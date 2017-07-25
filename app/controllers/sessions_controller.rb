class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.

    if @user && @user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the
      # user logged in when they navigate around our website.
      session[:user_id] = @user.id
      redirect_to '/'
    else
      # If the user's login does not work, redirect them back to login page
      redirect_to '/login', flash: { danger: "Oops, an error occurred while logging in. Please check your e-mail or password." }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
