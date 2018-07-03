class Step < ApplicationRecord
  belongs_to :energy_unit
  has_and_belongs_to_many :operations

  scope :not_fertilizer, -> { where.not(category: 'fertilizer')}

  scope :survey, -> { where(source_desc: 'SURVEY') }


  after_save :update_operations

  # def self.distinct_category_names
  #   distinct.pluck(:category)
  # end

  def self.titleize_category(category_name)
    case category_name
    when nil
      'Livestock/Uncategorized'
    when 'field'
      'Field Operations'
    else
      category_name.titleize
    end
  end

  protected
    def update_operations
    end
end
