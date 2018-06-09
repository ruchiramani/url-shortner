class UrlsController < ApplicationController

  def index

  end


  def create
    @url = Url.find_or_initialize_by(original: params[:url][:original])
    if @url.save
      render :json => {:result => @url, :status => 200}
    else
      render :json => {:result => 'unable to shorten the url', :status => 400}
    end
  end

  def show
  end

  def redirect
    url = Url.find_by(short: params[:short])
    binding.pry

      url.visited += 1
      url.save
      redirect_to "#{url.original}"
  end
end
