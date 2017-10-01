class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :destroy, :update]
  before_action :authenticate_user!

  # topics_path 
  def index
    @topics=Topic.all.order(:created_at => 'desc')
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
    if @topic.save
      redirect_to topics_path, notice: "投稿を作成しました"
    else
      render 'new'
    end
  end

  def confirm
    @topic = Topic.new(topic_params)
    render :new if @topic.invalid?
  end
private
  def topic_params
    Rails.logger.info "[DEBUG] topic_params in"
    params.require(:topic).permit(:title, :content)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end
