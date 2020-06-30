class Users::AnswersController < ApplicationController

  # good_answer作成
  def create
    comment = Comment.find(params[:comment_id])
    @answer = Answer.new(comment_id: params[:comment_id], user_id: comment.user.id)
    if @answer.save
      user = User.find(comment.user.id)
      user.update(answer_point: user.answer_point += 1)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # good_answer消去
  def destroy
    comment = Comment.find(params[:comment_id])
    if @answer = Answer.find_by(comment_id: params[:comment_id], user_id: comment.user_id)
      @answer.destroy
      user = User.find(comment.user.id)
      user.update(answer_point: user.answer_point -= 1)
    end
    redirect_back(fallback_location: root_path)
  end

end
