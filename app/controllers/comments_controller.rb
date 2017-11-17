class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update]
  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic

    respond_to do |format|
      if @comment.save
        format.html {redirect_to topic_path(@topic), notice: 'コメントを投稿しました。'}
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params) 
      #binding.pry
      #redirect_to topic_path(@comment.topic.id)
      #format.html {redirect_to topic_path(@comment.topic.id), notice:”コメントを編集しました！”}
      #redirect_to topic_path(@comment.topic.id), notice:”コメントを編集しました！”
      redirect_to topic_path(@comment.topic.id)
    else
      render 'edit'
    end
  end


  def destroy
    Rails.logger.info "[FB_DEBUG] Comment id #{params[:id]} being deleted"
    #binding.pry
    @comment.destroy
    respond_to do |format|
      format.js {render :index}
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:topic_id, :content)
  end
end
