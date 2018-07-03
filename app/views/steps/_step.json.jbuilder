json.extract! step, :id, :type, :slug, :name, :cost, :energy_unit_id, :energy_units_used, :category, :subcategory, :source_text, :source_url, :notes, :created_at, :updated_at
json.url step_url(step, format: :json)
