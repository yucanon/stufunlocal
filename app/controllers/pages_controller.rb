class PagesController < ApplicationController
  def index #views/index.html.erbを表示させるというアクション
    @users = User.all.page(params[:page]).per(3)
    if params[:search].present?

      if params["lat"].present? & params["lng"].present? 
        @latitude = params["lat"]
        @longitude = params["lng"]

        geolocation = [@latitude,@longitude]
      else
        geolocation = Geocoder.coordinates(params[:search])
        @latitude = geolocation[0]
        @longitude = geolocation[1]
      end

      @listings = Listing.near(geolocation, 1, order: 'distance')

    # 検索欄が空欄の場合
    else

      @listings = Listing.all

    end

    # Ransack q のチェックボックス一覧
    if params[:q].present? 

      if params[:q][:genre_eq_any].present?
        session[:genre_eq_any] = params[:q][:genre_eq_any]
        session[:IT] = session[:genre_eq_any].include?("IT")
        session[:Consultant] = session[:genre_eq_any].include?("コンサルタント")
        session[:Sales] = session[:genre_eq_any].include?("営業")
      else
        session[:genre_eq_any] = ""
        session[:IT] = false
        session[:Consultant] = false
        session[:Sales] = false
      end

    end 

    # Q条件をまとめたものをセッションQに入れる
    session[:q] = {"genre_eq_any"=>session[:genre_eq_any]}


    # ransack検索
    @search = @listings.ransack(session[:q])
    @result = @search.result(distinct: true)

     #リスティングデータを配列にしてまとめる 
    @arrlistings = @result.to_a
  end

  def howtouse
  end

  def search
    if params[:search].present?

      if params["lat"].present? & params["lng"].present? 
        @latitude = params["lat"]
        @longitude = params["lng"]

        geolocation = [@latitude,@longitude]
      else
        geolocation = Geocoder.coordinates(params[:search])
        @latitude = geolocation[0]
        @longitude = geolocation[1]
      end

      @listings = Listing.near(geolocation, 1, order: 'distance')

    # 検索欄が空欄の場合
    else

      @listings = Listing.all

    end

    # Ransack q のチェックボックス一覧
    if params[:q].present? 

      if params[:q][:genre_eq_any].present?
        session[:genre_eq_any] = params[:q][:genre_eq_any]
        session[:IT] = session[:genre_eq_any].include?("IT")
        session[:Consultant] = session[:genre_eq_any].include?("コンサルタント")
        session[:Sales] = session[:genre_eq_any].include?("営業")
      else
        session[:genre_eq_any] = ""
        session[:IT] = false
        session[:Consultant] = false
        session[:Sales] = false
      end

    end 

    # Q条件をまとめたものをセッションQに入れる
    session[:q] = {"genre_eq_any"=>session[:genre_eq_any]}


    # ransack検索
    @search = @listings.ransack(session[:q])
    @result = @search.result(distinct: true)

     #リスティングデータを配列にしてまとめる 
    @arrlistings = @result.to_a



  def ajaxsearch
    
    # まずajaxで送られてきた緯度経度をセッションに入れる
    if !params[:geolocation].blank?
      geolocation = params[:geolocation]
    end

    @listings = Listing.near(geolocation, 1, order: 'distance')

    #リスティングデータを配列にしてまとめる 
    @arrlistings = @listings.to_a

    # start_date end_dateの間に予約がないことを確認.あれば削除
    if ( !params[:start_date].blank? && !params[:end_date].blank? )

      session[:start_date] = params[:start_date]
      session[:end_date] = params[:end_date]

      start_date = Date.parse(session[:start_date])
      end_date = Date.parse(session[:end_date])

      @listings.each do |listing|

        # check the listing is availble between start_date to end_date
        unavailable = listing.reservations.where(
            "(? <= start_date AND start_date <= ?)
              OR (? <= end_date AND end_date <= ?) 
              OR (start_date < ? AND ? < end_date)",
            start_date, end_date,
            start_date, end_date,
            start_date, end_date
        ).limit(1)

        # delete unavailable room from @listings
        if unavailable.length > 0
          @arrlistings.delete(listing) 
        end 
      end
    end
  end

    # start_date end_dateの間に予約がないことを確認.あれば削除
    if ( !session[:start_date].blank? && !session[:end_date].blank? )

      start_date = Date.parse(session[:start_date])
      end_date = Date.parse(session[:end_date])

      @listings.each do |listing|

        # check the listing is availble between start_date to end_date
        unavailable = listing.reservations.where(
            "(? <= start_date AND start_date <= ?)
              OR (? <= end_date AND end_date <= ?) 
              OR (start_date < ? AND ? < end_date)",
            start_date, end_date,
            start_date, end_date,
            start_date, end_date
        ).limit(1)

        # delete unavailable room from @listings
        if unavailable.length > 0
          @arrlistings.delete(listing) 
        end 
      end
    end

  
  end
end
