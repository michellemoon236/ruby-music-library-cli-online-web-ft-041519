module Concerns::Findable
  
  # Class Methods
  def find_by_name(name)
    self.all.find { |song| song.name == name }
  end
  
  def find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name) 
    end
    
    #or
    # def find_or_create_by_name(name)
    # self.find(name) ? self.find(name) : self.create(name)
  end
  
end
