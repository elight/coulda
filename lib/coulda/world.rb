module Coulda
  class World
    def self.register_feature(feature, sexp)
      (@features ||= []) << [feature, sexp]
    end

    def self.features
      @features || []
    end
  end
end
