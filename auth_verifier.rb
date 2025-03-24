require_relative 'auth_service'

class AuthVerifier


  @auth_service 

  def initialize(app)

    @app = app
    @cookie_database = {}
    @auth_service = AuthService.instance
    
  end

  
  def call(env)

    req = Rack::Request.new(env)

    if req.path_info == "/auth" || req.path_info == "/auth/signin" || @auth_service.is_cookie_valid(req.cookies)

      return @app.call(env)
      
    end

    return Rack::Response.new(nil, 401, {}).finish()

  end


end
