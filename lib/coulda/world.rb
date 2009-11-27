module Coulda
  class World
    def self.register_feature(feature)
      (@features ||= []) << feature
    end

    def self.features
      @features || []
    end
  end
end
