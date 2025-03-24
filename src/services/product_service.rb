require 'singleton'

class ProductService

  include Singleton
  
  @@product_storage = []

  def get_all

    @@product_storage

  end


  def create_product(product)

    validation_message = validate_product(product) ;

    unless validation_message.empty? ; return validation_message end

    process_product(product, @@product_storage)

    return ""

  end


  def process_product(product, storage)

    local = Thread.new {

      sleep(5)
      
      storage.push(product)
      
    }

    local.join(0)
    

  end

  def validate_product(req_body)


    error_message = ""

    id = req_body["id"]
    name = req_body["name"]

    if !id.is_a?(Integer) ; error_message += "Id must be a number. " end

    if !name.is_a?(String) || name.empty? ; error_message += "Name must be a not empty String. " end

    error_message
    
  end

end
