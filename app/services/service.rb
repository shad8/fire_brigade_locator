module Service
  extend ActiveSupport::Concern

  class_methods do
    def method_missing(m, *args)
      new.send m, *args
    end
  end
end