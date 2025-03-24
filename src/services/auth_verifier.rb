require_relative 'auth_service'

class AuthVerifier


  @auth_service 

  def initialize(app)

    @app = app
    @auth_service = AuthService.instance
    
  end

  
  def call(env)

    req = Rack::Request.new(env)

    if req.path_info == "/auth" || req.path_info == "/auth/signin" || @auth_service.is_cookie_valid(req.cookies)

      return @app.call(env)
      
    end
    
    message = { "message" => "Invalid token" }
    Rack::Response.new(JSON.generate(message), 401, {"content-type" => "application/json"}).finish()
    
  end


end
