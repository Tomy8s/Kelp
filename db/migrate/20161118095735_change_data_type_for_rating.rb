class ChangeDataTypeForRating < ActiveRecord::Migration[5.0]
  def change
    change_column :restaurants, :rating, :float
  end
end
