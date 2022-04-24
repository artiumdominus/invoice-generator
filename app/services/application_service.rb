class ApplicationService
  def self.[](**kwargs)
    @callable ||= self.new.method(:call)
    @callable[**kwargs]
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
