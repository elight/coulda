module Coulda
  class World
    def self.register_feature(feature, name)
      (@features ||= []) << [feature, name]
    end

    def self.features
      @features || []
    end
  end
end
