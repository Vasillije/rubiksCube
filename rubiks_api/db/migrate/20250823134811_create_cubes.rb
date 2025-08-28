class CreateCubes < ActiveRecord::Migration[8.0]
  def change
    create_table :cubes do |t|
      t.json :state

      t.timestamps
    end
  end
end
