class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :reply, index: true
      t.references :question, index: true
      t.references :possible_answer, index: true
      t.string :value

      t.timestamps
    end
  end
end
