require 'delegate'
class AttHash < SimpleDelegator
  def initialize
    @hsh = {}
    super(@hsh)
  end

  def method_missing(foo, *args, &blk)
    if @hsh.respond_to?(foo)
      @hsh.send(foo, *args, &blk)
    else
     @hsh[foo.to_sym] = args
    end
  end
end
