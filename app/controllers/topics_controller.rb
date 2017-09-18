class TopicsController < ApplicationController
  def index
    @topics=Topic.all.order(:created_at => 'desc')
  end

  def new
    @topic=Topic.new
  end

  def create
    Topic.create(topic_params)
    redirect_to topics_path
  end

private
  def topic_params
    params.require(:topic).permit(:title, :content)
  end
end
