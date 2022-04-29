class ApplicationService
  def self.[](**kwargs)
    @callable ?
      @callable[**kwargs] :
      self.new.call(**kwargs)
  end

  def self.is(callable)
    @callable = callable
  end

  def self.>>(callable)
    @compositions ||= {}
    @compositions[callable.object_id] ||=
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
