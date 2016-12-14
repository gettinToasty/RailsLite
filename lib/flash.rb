require 'json'

class Flash

  attr_reader :now

  def initialize(req)
    ivar = req.cookies['_rails_lite_app_flash']
    @flash = ivar ? JSON.parse(ivar) : {}
    @now = {}
  end


  def []=(key, val)
    @flash[key.to_sym] = val || @now[key.to_sym] = val
  end

  def [](key)
    @flash[key.to_sym] || @now[key.to_sym]
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash',
                   path: '/',
                   value: @flash.merge(@now).to_json
                  )
  end
end
