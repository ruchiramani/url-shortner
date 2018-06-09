class UrlsController < ApplicationController

  def index

  end


  def create
    @url = Url.find_or_initialize_by(original: params[:url][:original])
    if @url.save
    else
      @error = "Please enter a valid URL beginning with 'http://' or 'https://'"
    end
    redirect_to '/'
  end

  def redirect
    url = Url.find_by(short: params[:short])
      url.visited += 1
      url.save
      redirect "#{url.original}"
  end
end
