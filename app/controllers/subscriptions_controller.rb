require 'paypal-sdk-rest'
include PayPal::SDK::REST
class SubscriptionsController < ApplicationController

  def subscribe
    #add code to make sure they haven't paid in the last 30 days
    sub = Subscription.find_by_user_id_and_page_id(params[:user_id],params[:page_id])
    if !!sub
      if self.make_payment
        sub.update_attribute(:number_of_payments, sub.number_of_payments+1);
        render json: "success"
      else
        render json: nil
      end
    else
      sub = Subscription.new(user_id: params[:user_id], page_id: params[:page_id])
      if self.make_payment
        sub.save!
        sub.update_attribute(:number_of_payments, 1)
        render json: "success"
      else
        render json: nil
      end
    end
  end

  def make_payment
    PayPal::SDK::REST.set_config(
      :mode => "sandbox", # "sandbox" or "live"
      :client_id => "EBWKjlELKMYqRNQ6sYvFo64FtaRLRR5BdHEESmha49TM",
      :client_secret => "EO422dn3gQLgDbuwqTjzrFgFtaRLRR5BdHEESmha49TM")

    # Build Payment object
    @payment = Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "credit_card",
        :funding_instruments => [{
          :credit_card => {
            :type => "visa",
            :number => "4417119669820331",
            :expire_month => "11",
            :expire_year => "2018",
            :cvv2 => "874",
            :first_name => "Joe",
            :last_name => "Shopper",
            :billing_address => {
              :line1 => "52 N Main ST",
              :city => "Johnstown",
              :state => "OH",
              :postal_code => "43210",
              :country_code => "US" }}}]},
      :transactions => [{
        :item_list => {
          :items => [{
            :name => "item",
            :sku => "item",
            :price => "1",
            :currency => "USD",
            :quantity => 1 }]},
        :amount => {
          :total => "1.00",
          :currency => "USD" },
        :description => "This is the payment transaction description." }]})

    return !!@payment.create

    # Create Payment and return the status(true or false)
    # if @payment.create
 #      @payment.id     # Payment Id
 #    else
 #      @payment.error  # Error Hash
 #    end
  end

end
