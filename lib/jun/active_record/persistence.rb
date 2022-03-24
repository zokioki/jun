# frozen_string_literal: true

module ActiveRecord
  module Persistence
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def create(attributes = {})
        object = new(attributes)
        object.save

        object
      end

      def primary_key=(value)
        @primary_key = value.to_sym
      end

      def primary_key
        defined?(@primary_key) ? @primary_key : :id
      end
    end

    def save
      if new_record?
        result = self.class.connection.execute("INSERT INTO #{self.class.table_name} (#{@attributes.keys.join(",")}) VALUES (#{@attributes.values.map { |v| "'#{v}'" }.join(",")}) RETURNING *;")
        @attributes[self.class.primary_key] = result.first[self.class.primary_key]
        @new_record = false
      else
        self.class.connection.execute("UPDATE #{self.class.table_name} SET #{@attributes.map { |k, v| "#{k} = #{v}" }.join(",")} WHERE id = #{id};")
      end

      true
    end

    def new_record?
      @new_record
    end

    def persisted?
      !new_record?
    end
  end
end
