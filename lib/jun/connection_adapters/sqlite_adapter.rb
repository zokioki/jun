# frozen_string_literal: true

require "sqlite3"

class SqliteAdapter
  def initialize
    @db = SQLite3::Database.new(Jun.root.join("db/app.db").to_s, results_as_hash: true)
  end

  def execute(sql)
    @db.execute(sql).each do |row|
      row.keys.each { |key| row[(key.to_sym rescue key) || key] = row.delete(key) }
    end
  end

  def columns(table_name)
    @db.table_info(table_name).map { |info| info["name"].to_sym }
  end
end
