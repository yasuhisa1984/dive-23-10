class VotesController < ApplicationController
#長くなりすぎなのでリファクタリングしたい
  def create
    if params[:question_or_answer] == "question"
      @question = params[:question_id]
      if current_user.question_voting_plus_or_minus_or_nil(@question)
        @vote = Vote.find(params[:id])
        @vote.destroy
        redirect_to question_path(@question)
      else
        @question = Question.find(params[:question_id])
        if params[:is_up] == "true"
          plus_or_minus = 1
        else
          plus_or_minus = -1
        end
        Vote.create(user_id: current_user.id, question_id: @question.id, plus_or_minus: plus_or_minus)
        redirect_to question_path(@question)
      end
    else
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
      if current_user.answer_voting_plus_or_minus_or_nil(@answer)
        @vote = Vote.find(params[:id])
        @vote.destroy
        redirect_to question_path(@question)
      else
        @answer = Answer.find(params[:answer_id])
        if params[:is_up] == "true"
          plus_or_minus = 1
        else
          plus_or_minus = -1
        end
        Vote.create(user_id: current_user.id, answer_id: @answer.id, plus_or_minus: plus_or_minus)
        redirect_to question_path(@question)
      end
    end
  end

  def destroy
    if params[:question_or_answer] == "question"
      @question = params[:question_id]
      if current_user.question_voting_plus_or_minus_or_nil(@question)
        @vote = Vote.find(params[:id])
        @vote.destroy
        redirect_to question_path(@question)
      else
        @question = Question.find(params[:question_id])
        plus_or_minus = -1
        Vote.create(user_id: current_user.id, question_id: @question.id, plus_or_minus: plus_or_minus)
        redirect_to question_path(@question)
      end
    else
      @answer = Answer.find(params[:answer_id])
      @question = @answer.question
      if current_user.answer_voting_plus_or_minus_or_nil(@answer)
        @vote = Vote.find(params[:id])
        @vote.destroy
        redirect_to question_path(@question)
      else
        @answer = Answer.find(params[:answer_id])
        plus_or_minus = -1
        Vote.create(user_id: current_user.id, answer_id: @answer.id, plus_or_minus: plus_or_minus)
        redirect_to question_path(@question)
      end
    end
  end
end
