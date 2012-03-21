class Terminal
  attr_accessor :products, :cart, :total
  def initialize
    @products = Hash.new()
    @cart = Array.new()
  end
  def scan_price(product, price)
    @products[product]=[price, price.include?(' or ')]
  end
  def scan(product)
    #add product to the cart
    @cart.push product
  end
  def price(product)
    return @products[product][0]
  end
  def total
    items = @cart.uniq
    retval = 0.00
    if @cart.count(items[0]) > 1 then
      if @products[itmes[0]][2] then
        #get the deal
        #compare if eligble

      end
    else
      retval += @products[items[0]][0].gsub('$','').match(/\d+\.\d+/).to_s.to_f
    end
    return retval
  end
end
