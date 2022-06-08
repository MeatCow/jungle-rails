# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    if user
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
