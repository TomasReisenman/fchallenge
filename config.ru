require 'json'
require_relative './src/controllers/product_controller'
require_relative './src/services/auth_verifier'
require_relative './src/controllers/auth_controller'

use AuthVerifier
use Rack::Deflater
use Rack::Static, :urls => ["/AUTHORS", "/openapi.yml"], :root => "public", :cascade => true,  :header_rules => [
             ["AUTHORS" , {'Content-Disposition' => 'attachment','Cache-Control' => 'max-age=86400'}],
             ["openapi.yml" , {'Cache-Control' => 'no-store'}],
       ]

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
