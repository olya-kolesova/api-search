class AddColumnZipCodeToMuseums < ActiveRecord::Migration[6.0]
  def change
    add_column :museums, :zip_code, :string
  end
end
