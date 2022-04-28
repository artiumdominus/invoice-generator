class ApplicationService
  def self.[](**kwargs)
    "> Calling #{self.name || "()"} with #{kwargs.inspect}"
    @callable ?
      @callable[**kwargs] :
      self.new.call(**kwargs)
  end

  def self.is(callable)
    @callable = callable
  end

  def self.>>(callable)
    Class.new(self).tap do |klass|
      klass.is -> (**kwargs) do
        case self[**kwargs]
        in { ok: data }
          callable[**data]
        in { error: }
          { error: }
        end
      end
    end
  end
end
