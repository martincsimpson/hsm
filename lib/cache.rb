class Cache
  CACHE_TTL=5
  @@cache = {}
  @@ttls = {}
  
  def self.get_or_set(cache_key)
    if @@cache[cache_key]
      if Time.now - @@ttls[cache_key] < CACHE_TTL
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
