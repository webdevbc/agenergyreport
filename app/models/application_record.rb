# ApplicationRecord is the parent class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
