class Cache
  @@cache_ttl=5
  
  @@cache = {}
  @@ttls = {}
  
  def self.set_cache_ttl(ttl)
    raise "Cache TTL should be a number" unless ttl.is_a?(Integer)
    @@cache_ttl = ttl
  end
  
  def self.key_is_valid?(cache_key)
    return false unless @@cache[cache_key]
    return false unless Time.now - @@ttls[cache_key] < @@cache_ttl
    true
  end
    
  def self.get_or_set(cache_key)
    if @@cache[cache_key]
      if Time.now - @@ttls[cache_key] < @@cache_ttl
        return @@cache[cache_key]
      else
        @@cache.delete(cache_key)
        @@ttls.delete(cache_key)
      end
    end
    
    response = yield
    
    @@cache[cache_key] = response
    @@ttls[cache_key] = Time.now
    
    response
  end
end
