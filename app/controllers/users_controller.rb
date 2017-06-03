class UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all_except(current_user)
    else
      @users = User.all
    end
  end

  def show
    @user = current_user
    @answers = current_user.answers.includes(:question)
    @questions = @user.questions
  end
end
