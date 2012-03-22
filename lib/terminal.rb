class Terminal
  attr_accessor :products, :cart, :total
  def initialize
    @products = Hash.new()
    @cart = Array.new()
  end
  def scan_price(product, price)
    @products[product]=parse_price price
  end
  def scan(product)
    #add product to the cart
    @cart.push product
  end
  def price(product)
    return @products[product][:string]
  end
  def total
    items = @cart.uniq
    retval = 0.00
    items.each do |item|
      pieces = @cart.count(item)
      product = @products[item]

      if pieces > 1 then
        if product[:deal] then
          case
          when pieces == product[:quantity]
            retval += product[:sale]
          when  pieces > product[:quantity]
            if (pieces % product[:quantity]) != 0 then
              retval += product[:price] * (pieces % product[:quantity])
              retval += product[:sale]
            elsif  (pieces % product[:quantity].to_i) == 0
              retval += product[:sale] * (pieces / product[:quantity])
            end
          when  pieces < product[:quantity].to_i
            retval +=  product[:price] * pieces
          end
        end
      else
        retval +=  product[:price]
      end
    end
    return retval
  end

  private
  def parse_price(price)
    discount = price.include?(' or ')
    amount = 0.00
    deal = ""
    quantity = 0
    sale = 0.00
    if discount
      amount,deal = price.split(' or ')
      amount.gsub!('$','')
      quantity,sale = deal.match(/(\d+).*for.*\$?(\d+\.\d+|\s\w+\s)/).to_a[1..2]
    end
    #do quantity and sale need to flip?
    if sale.to_f == 0.0
      quantity,sale = sale,quantity
      quantity = word_to_number(quantity.strip)
    end
    { :price => amount.to_f, :deal => discount, :quantity => quantity.to_i, :sale => sale.to_f, :string => price}
  end
  def word_to_number(word)
    words = %W[zero one two three four five six seven eight nine ten]
    return words.index(word)
  end
end
#(\d+).*for.*\$?(\d+\.\d+)
