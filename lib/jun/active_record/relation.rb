# frozen_string_literal: true

module ActiveRecord
  class Relation
    def initialize(klass)
      @klass = klass
      @where_clauses = []
    end

    def where!(condition)
      clause = condition.is_a?(String) ? condition : condition.map { |k, v| "#{k} = #{v}" }.join(" AND ")
      @where_clauses << clause

      self
    end

    def where(condition)
      clone.where!(condition)
    end

    def to_sql
      sql = "SELECT * FROM #{@klass.table_name}"
      sql += " WHERE #{@where_clauses.join(" AND ")}" if @where_clauses.any?

      sql
    end

    def records
      @records ||= @klass.find_by_sql(to_sql)
    end

    alias to_a records

    def first
      records.first
    end

    def each(&block)
      records.each(&block)
    end
  end
end
