# frozen_string_literal: true

# table_catalog                | postgres_to_redshift
# table_schema                 | public
# table_name                   | acquisition_pages
# table_type                   | BASE TABLE
# self_referencing_column_name |
# reference_generation         |
# user_defined_type_catalog    |
# user_defined_type_schema     |
# user_defined_type_name       |
# is_insertable_into           | YES
# is_typed                     | NO
# commit_action                |
#
class PgToRedshift
  class Table

    attr_accessor :attributes, :columns

    def initialize(attributes:, columns: [])
      self.attributes = attributes
      self.columns = columns
    end

    def name
      attributes["table_name"]
    end
    alias_method :to_s, :name

    def target_table_name
      name.gsub(/_view$/, "")
    end

    def columns=(column_definitions = [])
      @columns = column_definitions.map do |column_definition|
        Column.new(:attributes => column_definition)
      end
    end

    def columns_for_create
      columns.map do |column|
        %("#{column.name}" #{column.data_type_for_copy})
      end.join(", ")
    end

    def columns_for_copy
      columns.map(&:name_for_copy).join(", ")
    end

    def view?
      attributes["table_type"] == "VIEW"
    end

  end
end
