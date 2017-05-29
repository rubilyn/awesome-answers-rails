class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order(created_at: :desc)
  end

end


#
# class Admin::UsersController < ApplicationController
#   before_action :authenticate_user!
#   before_action :authorize_amin
#
#
#   def index
#     @users = User.order(created_at: :desc)
#   end
#
#   private
#   def authorize_amin
#     head :unauthorized unless current_user.is_admin?
#   end
#
# end
