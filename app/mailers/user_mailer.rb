class UserMailer < ActionMailer::Base
    default from: 'no-reply@jungle.com'
   
    def order_email(order)
     
      @order = order
      puts "LINE ITEMS"
      puts @order.line_items
      mail(to: @order.email, subject: @order.id)
    end

  end