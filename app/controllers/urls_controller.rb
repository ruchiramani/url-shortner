class UrlsController < ApplicationController

  def index
      render '/welcome'
  end


  def create
    @url = Url.find_or_initialize_by(original: params[:original])
    # if a custom url is requested but a shortened one for the original already exists, it will return the old one.
    @url.short = params[:short] if params[:short] && !self.short
    if @url.save
      render :json => {:result => @url, :status => 201}
    else
      render :json => {:result => 'unable to shorten the url', :status => 404}
    end
  end

  def show
    url = Url.find(params[:id])
    if url
     render :json => {:result => @url, :status => 201}
   else
     render :json = {:result => 'URL not found', :status => 404}
  end

  def redirect
    url = Url.find_by(short: params[:short])
    if url.nil?
      render :json => {:result => 'Unable to redirect', :status => 404}
    else
      url.update_visit
      redirect_to "#{url.original}"
    end
  end


  def get_stats
    url = Url.find(params[:id])
    if url
      histogram = UrlStats.generate_histogram(url.id)
      result = {:original_url => url.original, :date_created => url.created_at, :total_visits => url.visited, :histogram => histogram}
      render :json => {:result => result, :status => 201}
    else
      render :json => {:result => 'URL stats not found'}, :status => 404}
    end
  end

  def domain_stats
    urls = Url.where(domain: params[:domain])
    if urls.length > 1
      total_visits_for_domain = urls.reduce(0) { |total, url| total + url.visited }
      render :json => {:result => {total_visits_for_domain: total_visits_for_domain}, :status => 201}
    else
      render :json => {:result => 'Stats for domain not found', :status => 404}
   end
 end


end
