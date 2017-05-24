class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers
    @questions = @user.questions
  end
end
