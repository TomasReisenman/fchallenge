require 'digest'
require_relative 'auth_service'
require_relative 'local-util'

class AuthController

  BASE_PATH = "/auth"
  SALT = "!@3$%^&*"

  @auth_storage = {}
  @auth_service 

  include LocalUtil

  def initialize()

    @auth_storage = {}
    @auth_service = AuthService.instance
    @auth_storage["fudo"] = Digest::SHA256.hexdigest("oduf" + SALT)

  end


  def login(req)
    
    unless req.path_info == BASE_PATH && req.post? ; return nil end

    body = from_json(req.body)

    if body["user"] == nil || body["password"] == nil ; return Rack::Response.new(nil, 422, {}).finish() end

    check = @auth_storage[body["user"]] == Digest::SHA256.hexdigest(body["password"] + SALT)

    unless  check ;  return Rack::Response.new(nil, 400, {}).finish() end

    return Rack::Response.new(JSON.generate({"message" => "Welcome to fchallenge" }) , 200, {"Content-Type" => "application/json","Set-Cookie" => @auth_service.generate_cookie}).finish()
    
  end

end


   
