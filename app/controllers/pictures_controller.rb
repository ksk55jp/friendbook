class PicturesController < ApplicationController
  def index
  end

  def create
  end

  def update
  end

  def new
  end

  def edit
  end

  def destroy
  end
private
  def picture_param
    params.require(:picture).permit(:title, :alt)
  end
end
