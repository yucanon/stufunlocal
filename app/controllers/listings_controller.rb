class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show, :update, :basics, :address, :goalprice, :perprice, :genre, :photos, :articles, :bankaccount,:publish]
  before_action :access_deny, only: [:basics, :goalprice, :address, :perprice, :genre, :photos, :bankaccount, :publish]

  def index
    @listing = current_user.listing
  end

  def show
    @user = User.find(params[:id])
    @photos = @listing.photos
    @articles = @listing.articles
    @currentUserCharged = Charge.where("listing_id = ? AND user_id = ?",@listing.id,current_user.id).present? if current_user
    @reviews = @listing.reviews  
    @currentUserReview = @reviews.find_by(user_id:  current_user.id) if current_user
  end

  def new
    # 現在のユーザーのリスティングの作成
    @listing = current_user.build_listing
  end

  def create
    # パラメーターとともに現在のユーザーのリスティングを作成
    @listing = current_user.build_listing(listing_params)

    if @listing.save
      redirect_to manage_listing_basics_path(@listing), notice: "リスティングを作成・保存をしました"
    else
      redirect_to new_listing_path, notice: "リスティングを作成・保存出来ませんでした"
    end

  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to :back, notice: "更新できました"
    end
  end

  def basics
  end

  def address
  end

  def goalprice
  end

  def perprice
  end

  def bankaccount
    @user = @listing.user
    session[:listing_id] = @listing.id
  end

  def photos
  end

  def genre
  end

  def articles
  end

  def publish
  end

  def not_checked
    @listing = Listing.find(params[:listing_id])
    @listing.update(not_checked: params[:not_checked])
    render :nothing => true
  end



  private
  def listing_params
    params.require(:listing).permit(:price, :goal_price, :address, :listing_title, :listing_content, :video, :image,:genre, :active,:picup)
  end

  def set_listing
    @listing = Listing.find(params[:id]) 
  end

  def access_deny
    if !(current_user == @listing.user)
      redirect_to root_path, notice: "他人の編集ページにはアクセスできません"
    end
  end

end
