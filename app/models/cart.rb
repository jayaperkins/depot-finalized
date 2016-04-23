class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.to_a.sum { |item| item.total_price } #convert to array and then sum the total prices of all the different line items
  end

  def add_product(product_id)
    current_line_item = line_items.find_by(product_id: product_id)
    if current_line_item
      current_line_item.quantity += 1
    else
      current_line_item = line_items.build(product_id: product_id)
    end
    current_line_item #returns the current_line_item so that you can access it outside the function
  end
end