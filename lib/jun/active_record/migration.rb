# frozen_string_literal: true

module ActiveRecord
  class Migration
    def create_table(table_name, options = {})
      sql = "CREATE TABLE IF NOT EXISTS #{table_name}"
      column_options = options[:columns] || []

      columns_sql = column_options.map do |column|
        next(column) if column.is_a?(String)

        column_sql = []

        column_sql << column[:name]
        column_sql << column[:type]&.to_s&.upcase
        column_sql << "PRIMARY KEY" if column[:primary_key] == true
        column_sql << "NOT NULL" if column[:null] == false
        column_sql << "DEFAULT #{column[:default]}" if column[:default]
        column_sql << "UNIQUE" if column[:unique] == true

        column_sql.compact.join(" ")
      end

      sql += " (#{columns_sql.join(", ")})"
      sql += ";"

      ActiveRecord::Base.connection.execute(sql)
    end

    def drop_table(table_name)
      ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS #{table_name};")
    end
  end
end
