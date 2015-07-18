class ChargesController < ApplicationController

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.name}",
     amount: 15_00
   }
 end

  def create
    # Creates a Stripe Customer object, for associating
      # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
    #update the current_users stripe_customer_id (customer.id in this context) as well...
    current_user.update_attributes(role: 'premium', stripe_customer_id: customer.id)

    flash[:success] = "Thank you, #{current_user.email}! Enjoy your Blocipedia Subscription."
    redirect_to root_path # or wherever
  
  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end
end
