class CallbacksController < ApplicationController
  def index
    omniauth_data = request.env['omniauth.auth']

    user = User.find_from_omniauth(omniauth_data)
    user ||= User.create_from_omniauth(omniauth_data)
    session[:user_id] = user.id

    if (user.oauth_token != omniauth_data['credentials']['token'] ||
      user.oauth_secret != omniauth_data['credentials']['secret'])
      user.update(
        oauth_token: omniauth_data['credentials']['token'],
        oauth_secret: omniauth_data['credentials']['secret']
      )
    end

    if user.valid?
      redirect_to home_path, notice: "Thanks for signing in with #{params[:provider].capitalize}!"
    else
      redirect_to home_path, alert: user.pretty_errors
    end
  end
end
