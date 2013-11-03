class BookmarksController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :edit, :update]
  before_filter :set_tags, only: [:new, :create, :edit, :update]

  def index
    respond_to do |format|
      format.html do
        @bookmarks = Bookmark.order('created_at DESC').group_by { |b| b.created_at.to_date }
      end
      format.atom do
        @bookmarks = Bookmark.order('created_at DESC')
      end
    end
  end

  def show
    if params[:url] =~ /^\d+$/
      bookmark = Bookmark.find(params[:url])
      redirect_to bookmark_path(CGI.escape(bookmark.url))
      return
    end
    @bookmark = Bookmark.find_by_url!(params[:url])
    respond_to do |format|
      format.html
      format.json do
        headers['Access-Control-Allow-Origin'] = '*'
        render :json => @bookmark
      end
    end
  end

  def new
    if bookmark = Bookmark.find_by_url(params[:url])
      redirect_to edit_bookmark_path(bookmark)
    else
      @bookmark = Bookmark.new(url: params[:url], title: params[:title])
    end
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    bookmark_params = params[:bookmark]
    bookmark_params.delete(:url)
    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmarks_path
    else
      render :edit
    end
  end

  private

    # NOTE: This uses lazy-loading so it won't query the database for redirect cases.
    def set_tags
      @tags = Tag.select(:name)
    end
end