class CreateOperationsStepsJoinTable < ActiveRecord::Migration::Current
  def change
    create_join_table :operations, :steps do |t|
      t.index :operation_id
      t.index :step_id
    end
  end
end
