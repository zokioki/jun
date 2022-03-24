# frozen_string_literal: true

require_relative "../connection_adapters/sqlite_adapter"
require_relative "./persistence"

module ActiveRecord
  class Base
    include ActiveRecord::Persistence

    def initialize(attributes = {})
      @attributes = attributes
      @new_record = true
    end

    def method_missing(name, *args)
      if self.class.connection.columns(self.class.table_name).include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.find(id)
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i} LIMIT 1").first
    end

    def self.all
      ActiveRecord::Relation.new(self)
    end

    def self.where(*args)
      all.where(*args)
    end

    def self.find_by_sql(sql)
      connection.execute(sql).map do |attributes|
        object = new(attributes)
        object.instance_variable_set("@new_record", false)

        object
      end
    end

    def self.table_name
      name.downcase.pluralize
    end

    def self.connection
      @@connection ||= SqliteAdapter.new
    end
  end
end
