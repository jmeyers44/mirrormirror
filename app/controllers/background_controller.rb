class BackgroundController < ApplicationController
  def image
    binding.pry
    redirect_to "image_tag('bg/#{rand(3)}.jpg')"
  end
end
