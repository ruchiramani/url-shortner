class UrlsController < ApplicationController

  def index
      render '/welcome'
  end


  def create
    @url = Url.find_or_initialize_by(original: params[:original])
    # if a custom url is requested but a shortened one for the original already exists, it will return the old one.
    @url.short = params[:short] if params[:short] && !self.short
    if @url.save
      render :json => {:result => @url, :status => 200}
    else
      render :json => {:result => 'unable to shorten the url', :status => 400}
    end
  end

  def show
    @url = Url.find(params[:id])
    render :json => {:result => @url, :status => 201}
  end

  def redirect
    url = Url.find_by(short: params[:short])
    if url.nil?
      render :json => {:result => 'Unable to redirect', :status => 400}
    else
      url.update_visit
      redirect_to "#{url.original}"
    end
  end


  def get_stats
      url = Url.find(params[:id])
      histogram = UrlStats.generate_histogram(url.id)
      result = {:original_url => url.original, :date_created => url.created_at, :total_visits => url.visited, :histogram => histogram}
      render :json => {:result => result, :status => 202}
  end
end
