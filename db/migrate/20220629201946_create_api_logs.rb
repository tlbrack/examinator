class CreateApiLogs < ActiveRecord::Migration[7.0]
  def change
    # would probably use other datatypes if not on sqlite ie: (inet, jsonb, etc)
    create_table :api_logs do |t|
      t.string :ip
      t.string :request_uri
      t.string :request_method
      t.text :request_body
      t.text :request_params
      t.text :response_body
      t.string :response_status_code

      t.timestamps
    end
  end
end
