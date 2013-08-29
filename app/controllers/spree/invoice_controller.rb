module Spree
  class InvoiceController < BaseController

    def index
      @orders = Order.all
      @address = @orders.bill_address
      @invoice_prints = spree_current_user.has_spree_role?(:admin) ? Spree::Invoice.find_or_create_by_order_id({:order_id => order_id, :user_id => @order ? @order.user_id : nil}) : spree_current_user.invoices.find_or_create_by_order_id(order_id)
      if @invoice_prints
        respond_to do |format|
          format.pdf  { send_data @invoice_prints.generate_pdf(request, spree_current_user.has_spree_role?(:admin)), :filename => "#{@invoice_prints.invoice_number}.pdf", :type => 'application/pdf' }
          format.html { render :file => SpreeInvoice.invoice_template_path.to_s, :layout => false }
        end
      else
        if spree_current_user.has_spree_role?(:admin)
          return redirect_to(admin_orders_path, :notice => t(:no_such_order_found, :scope => :spree))
        else
          return redirect_to(orders_path, :alert => t(:no_such_order_found, :scope => :spree))
        end
      end
    end

    def show
      order_id = params[:order_id].to_i
      @order = Order.find_by_id(order_id)
      @address = @order.bill_address
      @invoice_print = spree_current_user ? Spree::Invoice.find_or_create_by_order_id({:order_id => order_id, :user_id => @order ? @order.user_id : nil}) : spree_current_user.invoices.find_or_create_by_order_id(order_id)
      if @invoice_print
        respond_to do |format|
          format.pdf do
            send_data @invoice_print.generate_pdf(request, spree_current_user.has_spree_role?(:admin)), :filename => "#{@invoice_print.invoice_number}.pdf", :type => 'application/pdf'
          end
          format.html { redirect_to root_path }
        end
      else
        if spree_current_user.has_spree_role?(:admin)
          return redirect_to(admin_orders_path, :notice => t(:no_such_order_found, :scope => :spree))
        else
          return redirect_to(orders_path, :alert => t(:no_such_order_found, :scope => :spree))
        end
      end

    end
  end
end
