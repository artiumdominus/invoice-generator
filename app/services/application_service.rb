class ApplicationService

  def self.[](*args, **kwargs)
    @callable.nil? ?
      self.new.call(*args, **kwargs) :
      @callable[*args, **kwargs]
  end

  def self.is(callable)
    @callable = callable
  end

  def self.>>(callable)
    Class.new(self).tap do |klass|
      klass.is -> (*args, **kwargs) do
        case self[*args, **kwargs]
        in { ok: data }
          callable[**data]
        in { error: }
          error
        end
      end
    end
  end
  # TODO: Sholud I remove the possibility of *args?
end