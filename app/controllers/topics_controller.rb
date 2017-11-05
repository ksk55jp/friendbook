class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!

  # topics_path 
  def index
    @topics=Topic.all.includes(:user).order(:created_at => 'desc')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments.includes(:user)
  end

  # new_topic_path 
  def new
    if params[:back]
      @topic = Topic.new(topic_params)
    else
      @topic=Topic.new
    end
  end

  # edit_topic_path
  def edit
  end

  # topic_path(id)  (PATCH/PUT)
  def update
    if @topic.update(topic_params) 
      redirect_to topics_path, notice: '投稿への変更を保存しました。'
    else
      render 'edit'
    end
  end

  # topic_path(id) (DELETE)
  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "投稿を削除しました"
  end

  # topics_path (POST)
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "投稿を作成しました"
      NoticeMailer.sendmail_fb(@topic).deliver
    else
      render 'new'
    end
  end

  def confirm
    #binding.pry
    @topic = Topic.new(topic_params)
    render :new if @topic.invalid?
  end

  def pictures
    @topic = Topic.find(params[id])
    @pictures = @topic.pictures
  end
private
  def topic_params
    Rails.logger.info "[DEBUG] topic_params in"
    params.require(:topic).permit(:title, 
                                  :content,
         pictures_attributes: [
          :_destroy,
          :id,
          :image,
          :image_cache,
          :title,
          :alt,
          :topic_id,
        ],)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end
