class ImagesController < ApplicationController

  def new
    @image = Image.build.params(image_params)
    @image.post_id = params[:post_id]
    @image.save
  end

  def show
    @image = Image.find(params[:id])
  end
  
  # def index
  #   @image = Image.find(params[:id])
  # end

  private

  def image_params
    params.require(:image).permit(
      :file,
      :hint,
      :alt,
      :post_id,
      )
  end

end