class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: [:index, :show]

  def index
    articles = Article.recent
      .page(params[:page])
      .per(params[:per_page])
    render json: articles
  end

  def show
    render json: Article.find(params[:id])
  end

  def create
    article = Article.new(article_params)
    #save method calls valid? and returns true or false
    #adding ! makes it raise an error if returning false
    article.save!
    render json: article, status: :created
  rescue
    render json: article, adapter: :json_api,
      serializer: ErrorSerializer,
      status: :unprocessable_entity
  end

  private
  def article_params
    params.require(:data).require(:attributes)
    .permit(:title, :content, :slug) ||
    ActionController::Parameters.new
  end

end
