module LocalUtil

def to_json(obj)

  result_hash = {}
  
  obj.instance_variables.each {|var| result_hash[var.to_s.delete("@")] = obj.instance_variable_get(var) }               
  JSON.generate(result_hash)
end


def from_json(obj)

  JSON.parse(obj.string)

end

end
