# frozen_string_literal: true

require_relative '../migration_generator'
require_relative '../../../mergration/parser'
require 'active_support/core_ext/string/inflections'
require 'active_record/connection_adapters/abstract/schema_definitions'

module Mergration
  class TypeError < StandardError; end
  class NotFoundError < StandardError; end

  # See https://github.com/rails/rails/blob/984c3ef2775781d47efa9f541ce570daa2434a80/activerecord/lib/active_record/connection_adapters/abstract/schema_definitions.rb#L257-L258
  TYPES = %i[bigint binary boolean date datetime decimal float integer json string text time timestamp
             virtual references].freeze

  class InstallGenerator < MigrationGenerator
    source_root File.expand_path('templates', __dir__)

    desc 'Generates a migration from entities described on mermaid.'

    def create_migration_file
      files = parse_file
      files.each do |file|
        file.each do |f|
          @entity = f[:entity]
          @attributes = f[:attributes]

          @attributes.each do |attribute|
            type = attribute[:type]
            unless ActiveRecord::ConnectionAdapters::Table.instance_methods.include?(type.to_sym)
              raise Mergration::TypeError, "Invalid type '#{type}' is given"
            end
          end

          add_mergration_migration(
            'create_entity',
            table_name: table_name,
            entity: entity,
            attributes: attributes
          )
        end
      end
    end

    private

    def parse_file
      files = Dir.glob(File.expand_path('docs/mermaid/*.md'))
      raise Mergration::NotFoundError, 'No markdown files found on docs/mermaid' if files.blank?

      results = []
      files.each do |file|
        results << Mergration::Parser.parse(file)
      end
      results
    end

    def table_name
      @entity.downcase.camelize.pluralize
    end

    def entity
      @entity.downcase.pluralize
    end

    def attributes
      @attributes.map do |attribute|
        unless TYPES.include? attribute[:type].to_sym
          raise Mergration::TypeError,
                "Invalid type #{attribute[:type]} for attribute #{attribute[:name]}"
        end

        attribute[:constraint] = '' if attribute[:constraint] == 'PK' # currentyly not support PK
        attribute[:constraint] = 'foreign_key: true' if attribute[:constraint] == 'FK'
        attribute[:constraint] = 'index: { unique: true }' if attribute[:constraint] == 'UK'
        attribute
      end
    end
  end
end
