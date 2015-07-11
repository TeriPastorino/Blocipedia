class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
    # authorize @wikis
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Your wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an every saving yoru wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    #@users = User.all
    # authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.update_attributes(wiki_params)
    # authorize @wiki
    if @wiki.save
      flash[:notice] = "Your changes have been made."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
    end
  end


  def destroy
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
    if @wiki.delete
      flash[:notice] = "\"#{@wiki.title}\" was deleted"
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleted the wiki. Please try again."
      render :show
    end
  end

  private 

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
