require_relative 'local-util'

class ProductController

  extend LocalUtil

  BASE_PATH = "/products"

  @@storage = []
  
 
  def self.get_all(req)

    unless req.path_info == BASE_PATH && req.get? ; return nil end
    
    [200, {"content-type" => "application/json" }, [JSON.generate(@@storage)]]
  end

  def self.get_by_id(req)

    # split by /
    # if arr.length != 2 out
    # req.get? out
    # if arr[0] != BASE_PATH out
    # if arr[1] not number out


  end

  def self.create(req)

    unless req.path_info == BASE_PATH && req.post? ; return nil end

    body = from_json(req.body)

    process_product(body)

    puts "Result in  #{Time.new}"        
    [202, {"content-type" => "application/json" }, ["OK"]]
    
  end

  def self.process_product(product)

    local = Thread.new { sleep(5)
      
      @@storage.push(product)
      puts "In thread #{Time.new} "
    }

    local.join(0)
    

  end


  def self.process(req, res)


    if res != nil ; return res end
    
    res = get_all(req)

    if res != nil; return res end

    res = create(req)

    if res != nil; return res end

    res

  end  

end


class Product

  def initialize(id, description)

    id = id
    description = description

  end

end
