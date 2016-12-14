require 'json'
require 'byebug'

class Flash

  attr_reader :now

  def initialize(req)
    ivar = req.cookies['_rails_lite_app_flash']
    @flash = {}
    @now = ivar ? JSON.parse(ivar) : {}
  end


  def []=(key, val)
    @flash[key.to_s] = val
  end

  def [](key)
    @flash[key.to_s] || @now[key.to_s]
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash',
                   path: '/',
                   value: @flash.to_json
                  )
  end
end
