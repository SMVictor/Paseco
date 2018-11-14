json.extract! customer, :id, :name, :business_name, :tradename, :representativr_id, :representative_name, :legal_document, :legal_document, :phone_number, :email, :contact, :payment_method, :payment_conditions, :created_at, :updated_at
json.url customer_url(customer, format: :json)
