# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    if User.authenticate_with_credentials(:email, :password)
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
