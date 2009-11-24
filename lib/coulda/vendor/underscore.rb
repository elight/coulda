class String
  def super_custom_underscore
    self.gsub(/::/, '/').
      gsub(/[^A-Za-z0-9]/,'_').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      downcase
  end
end
