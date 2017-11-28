class ChargesController < ApplicationController
  def new
  	@listing = Listing.find(params[:listing_id])
    @user = current_user
    @price = params[:charge][:price]
  end

  def create
    @listing = Listing.find(params[:listing_id])
      token = params[:stripeToken]


      user = @listing.user

      # Charge 
      amount = params[:price]

      #fee
      fee = (amount.to_i * 0.1).to_i


       @customer = Stripe::Customer.retrieve(current_user.customer_id)

       @customer.source = params[:stripeToken]

       @customer.save

      begin
        charge = Stripe::Charge.create({
          :amount => params[:price],
          :currency => 'jpy',
          :customer => @customer.id,
        }, :stripe_account => user.stripe_user_id)


        flash[:notice] = "Charged successfully!"

      rescue Stripe::CardError => e
        error = e.json_body[:error][:message]
        flash[:error] = "Charge failed! #{error}"
      end
      
      @charge = Charge.create(charge_params)
      redirect_to @charge.listing, notice: "支払いが完了しました。" 

  end

  private
    def charge_params
      params.require(:charge).permit(:price, :listing_id, :listing_title, :listing_content, :goal_price, :name).merge(user_id: current_user.id)
    end
end
