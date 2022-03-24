# frozen_string_literal: true

module ActiveRecord
  class Migration
    def up
      raise NoMethodError, "Subclass must implement method."
    end

    def down
      raise NoMethodError, "Subclass must implement method."
    end

    def add_column(table_name, column_name, column_type, options = {})
      sql = ["ALTER TABLE #{table_name} ADD COLUMN #{column_name}"]

      sql << column_type.to_s.upcase
      sql << "NOT NULL" if options[:null] == false
      sql << "DEFAULT #{options[:default]}" if options[:default]
      sql << "UNIQUE" if options[:unique] == true

      execute(sql.join(" "))
    end

    def remove_column(table_name, column_name)
      execute("ALTER TABLE #{table_name} DROP COLUMN #{column_name};")
    end

    def create_table(table_name, options = {})
      sql = "CREATE TABLE IF NOT EXISTS #{table_name}"
      column_options = []

      if options[:id] || !options.key?(:id)
        column_options << {
          name: :id,
          type: :integer,
          primary_key: true,
          null: false
        }
      end

      column_options += options.fetch(:columns, [])

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

      execute(sql)
    end

    def drop_table(table_name)
      execute("DROP TABLE IF EXISTS #{table_name};")
    end

    def rename_table(old_table_name, new_table_name)
      execute("ALTER TABLE #{old_table_name} RENAME TO #{new_table_name};")
    end

    def execute(*args)
      ActiveRecord::Base.connection.execute(*args)
    end
  end
end
