class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      return redirect_to '/'
    end

    redirect_to '/login'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
