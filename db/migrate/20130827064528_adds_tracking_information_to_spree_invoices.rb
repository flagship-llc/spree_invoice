class AddsTrackingInformationToSpreeInvoices < ActiveRecord::Migration
  def change
    add_column :spree_invoices, :pdf_counter, :integer, default: 0
    add_column :spree_invoices, :last_pdf_download, :datetime
  end
end
