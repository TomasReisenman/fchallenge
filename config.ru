require 'json'
require_relative 'response'
require_relative 'product_controller'
require_relative 'auth_verifier'
require_relative 'auth_controller'

use AuthVerifier
use Rack::Deflater
use Rack::Static, :urls => ["/AUTHORS", "/openapi.yml"], :root => "public", :cascade => true,  :header_rules => [
             ["AUTHORS" , {'Content-Disposition' => 'attachment','Cache-Control' => 'max-age=86400'}],
             ["openapi.yml" , {'Cache-Control' => 'no-store'}],
       ]


# map "/other" do
  
#   run do |env|
#     req = Rack::Request.new(env)

#     puts req.path_info
#     puts req.fullpath
    
#     second = Response.new("Nestor", "Piazola")
    
#     result = [200, {"content-type" => "application/json" }, [to_json(req)]]
#   end


# end


map "/auth" do

  run do |env|

    req = Rack::Request.new(env)
    auth_controller = AuthController.new
    auth_controller.process(req)

  end

end


map "/products" do

  run do |env|

    req = Rack::Request.new(env)
    product_controller = ProductController.new
    product_controller.process(req)

  end

end


# run do |env|

  
#   req = Rack::Request.new(env)
#   response = {}
  
#   auth_controller = AuthController.new

#   result = auth_controller.login(req)

#   result = ProductController::process(req, result)

#   if result == nil

#     result = [404, {"content-type" => "application/json" }, []]

#   end

#   result

# end
