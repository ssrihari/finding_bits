class CreateApiResponses < ActiveRecord::Migration
  def change
    create_table :api_responses do |t|
      t.string :language
      t.string :search_snippet
      t.string :response_json
      t.string :status

      t.timestamps
    end
  end
end
