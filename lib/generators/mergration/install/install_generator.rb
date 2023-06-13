# frozen_string_literal: true

require_relative '../migration_generator'
require_relative '../../../mergration/parser'
require 'active_support/core_ext/string/inflections'

module Mergration
  class InstallGenerator < MigrationGenerator
    source_root File.expand_path('templates', __dir__)

    desc 'Generates a migration from entities described on mermaid.'

    def create_migration_file
      files = parse_file
      files.each do |file|
        file.each do |f|
          @entity = f[:entity]
          @attributes = f[:attributes]
          add_mergration_migration(
            'create_dummy_tables',
            table_name: table_name,
            entity: entity,
            attributes: attributes,
          )
        end
      end
    end

    private

    def parse_file
      files = Dir.glob(File.expand_path('docs/mermaid/*.md'))
      raise 'No markdown files found on docs/mermaid' if files.blank?

      results = []
      files.each do |file|
        results << Mergration::Parser.parse(file)
      end
      puts results
      results
    end

    def table_name
      @entity.camelize.pluralize
    end

    def entity
      @entity
    end

    def attributes
      @attributes
    end
  end
end
