# Admin Panel buttons

Deface::Override.new(:virtual_path => %q{spree/admin/orders/index},
                     :remove => '#listing_orders > colgroup',
                     :name => 'remove_listing_orders_colgroup')

# Deface::Override.new(:virtual_path => %q{spree/admin/orders/index},
#                      :insert_before => "[data-hook='admin_orders_index_header_actions']",
#                      :name => "invoice_print_header",
#                      :text => "<th><%= t(:invoice, :scope => :spree) %></th>")

# Deface::Override.new(:virtual_path => %q{spree/admin/orders/index},
#                      :insert_before => "[data-hook='admin_orders_index_row_actions']",
#                      :name => "invoice_print_link",
#                      :text => %q{<td><%= link_to "#{image_tag('admin/icons/pdf.png')} #{t(:download, :scope => :spree)}".html_safe, pdf_invoice_path(:order_id => order.id, :format => :pdf) %></td>})

Deface::Override.new(:virtual_path => %q{spree/admin/shared/_order_tabs},
                     :insert_top => 'ul[data-hook="admin_order_tabs"]',
                     :name => 'add_invoice_to_order_detail_page',
                     :text => '<li><%= link_to "#{image_tag(\'admin/icons/pdf.png\')} #{t(:full_download_invoice, :scope => :spree)}".html_safe, pdf_invoice_path(:order_id => @order.id, :format => :pdf) if @order.paid? %></li>')
