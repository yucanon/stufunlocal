class ArticlesController < ApplicationController
  def show 
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    
      if @article.save
        render json: { message: "success", articleId: @article.id }, status: 200
      else
        render json: { error: @article.errors.full_messages.join(", ") }, status: 400
      end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
  respond_to do |format|
    if @article.update(article_params) && @article.video.recreate_versions!
      format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      format.json { head :no_content }
    else
      format.html { render action: 'edit' }
      format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end
end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def list
        listing = Listing.find(params[:listing_id])

        articles = []
        Article.where(listing_id: listing.id).each do |article|
            new_article = {
                id: article.id,
                name: article.image_file_name,
                size: article.image_file_size,
                src: article.image(:thumb)
            }
            article.push(new_article)
        end
        render json: { videos: :articles }
    end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :video, :listing_id)
    end
end
