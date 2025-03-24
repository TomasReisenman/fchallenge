require_relative '../services/local_util'
require_relative '../services/product_service'

class ProductController

  include LocalUtil

  def initialize()

    @product_service = ProductService.instance

  end
  
 
  def get_all(req)

    unless req.path_info == ""  && req.get? ; return nil end
    Rack::Response.new(JSON.generate(@product_service.get_all), 200, {"content-type" => "application/json"}).finish()
    
  end

  def create(req)

    unless req.path_info == ""  && req.post? ; return nil end

    body = from_json(req.body)

    error_message =  @product_service.create_product(body) ;

    message = { "message" => error_message }
        
    unless error_message.empty? ; return  Rack::Response.new(JSON.generate(message), 422, {"content-type" => "application/json"}).finish() end

    message = { "message" => "Product received . Will be created in 5 sec" }
    Rack::Response.new(JSON.generate(message), 202, {"content-type" => "application/json"}).finish()
        
  end

  def process(req)

    res = get_all(req)

    if res != nil; return res end

    res = create(req)

    if res != nil; return res end

    return Rack::Response.new(nil, 404, {}).finish()

  end

end

