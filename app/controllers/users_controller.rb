class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all_except(current_user)
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers
    @questions = @user.questions
  end
end
