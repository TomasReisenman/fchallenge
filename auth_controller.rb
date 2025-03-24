require 'digest'
require_relative 'auth_service'
require_relative 'local-util'

class AuthController

  BASE_PATH = "/auth"
  SALT = "!@3$%^&*"

  @auth_service 

  include LocalUtil

  def initialize()

    @auth_service = AuthService.instance

  end


  def login(req)

    unless req.path_info == ""  && req.post? ; return nil end

    body = from_json(req.body)

    if body["user"] == nil || body["password"] == nil ; return Rack::Response.new(nil, 422, {}).finish() end

    cookie = @auth_service.login(body["user"], body["password"])

    if cookie == nil ; return Rack::Response.new(nil, 400, {}).finish() end

    return Rack::Response.new(JSON.generate({"message" => "Welcome to fchallenge" }) , 200, {"Content-Type" => "application/json","Set-Cookie" => cookie}).finish()
    
  end


  def singin(req)

    unless req.path_info == "/signin"  && req.post? ; return nil end

    body = from_json(req.body)

    error_message =  @auth_service.signin(body)

    message = { "message" => error_message }
        
    unless error_message.empty? ; return  Rack::Response.new(JSON.generate(message), 422, {"content-type" => "application/json"}).finish() end

    message = { "message" => "Account Created" }
    Rack::Response.new(JSON.generate(message), 202, {"content-type" => "application/json"}).finish()

  end


  def process(req)

    res = login(req)

    if res != nil; return res end

    res = singin(req)

    if res != nil; return res end

    return Rack::Response.new(nil, 404, {}).finish()

  end


end


   
