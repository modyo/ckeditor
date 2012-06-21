class Ckeditor::PicturesController < Ckeditor::ApplicationController

  before_filter :init_site

  def index
    @pictures = Ckeditor.picture_model.find_all(ckeditor_pictures_scope) if @site
    respond_with(@pictures)
  end

  def create
    @picture = Assets::Picture.new( :site_id => @site.id ) if @site
    respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture, :location => pictures_path)
  end

  protected

  def find_asset
    @picture = Ckeditor.picture_model.get!(params[:id])
  end

  def init_site
    @account = Account.find_by_host(request.subdomain)

    if params[:current_site].present?
      @site = @account.sites.find_by_host(params[:current_site])
    end
  end

end
