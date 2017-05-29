class SessionsController < ApplicationController
  def new
  end

  def create
    # render json: params
    #we have the user's email & pw from the params
    #1. find the user by their email
    #2. if found, we authenticate the user with the given pw
    #3. if not found, we alert the user with wrong credentials

    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Thank you for signing in! ❤️'
    else
      #flash.now makes the flash message available to the current request as opposed to next request with just `flashf`
      flash.now[:alert] = 'Wrong credentials!'
      render :new
    end

  end


  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: 'Signed Out! ✨'
  end

end
