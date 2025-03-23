# var = ::Rack::Utils::HTTP_STATUS_CODES
require 'rack/utils'

class Response


  def initialize(name, sur)
    @name = name
    @sur = sur
    
  end


end

def to_json(obj)

  result_hash = {}
  
  obj.instance_variables.each {|var| result_hash[var.to_s.delete("@")] = obj.instance_variable_get(var) }               
  JSON.generate(result_hash)
end


def get_code()

  var = ::Rack::Utils::HTTP_STATUS_CODES
  return var
end

# use Rack::Static, :urls => ["/"], :root => "public", :header_rules => 
#          [:all, {'Content-Disposition' => 'attachment'}]
#        ]
