class UsersController < ApplicationController
  def index
    @users_except_current_user = User.all_except(current_user)
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers
    @questions = @user.questions
  end
end
