# frozen_string_literal: true

require_relative '../migration_generator'
require_relative '../../../mergration/parser'

module Mergration
  class InstallGenerator < MigrationGenerator
    source_root File.expand_path('templates', __dir__)

    desc 'Generates a migration from entities described on mermaid.'

    def create_migration_file
      parse_file
      add_mergration_migration(
        'create_dummy_tables',
        table_name: table_name,
        attributes: attributes,
      )
    end

    private

    def parse_file
      files = Dir.glob(File.expand_path('docs/mermaid/*.md'))
      raise 'No markdown files found on docs/mermaid' if files.blank?

      results = []
      files.each do |file|
        results << Mergration::Parser.parse(file)
      end
      results
    end

    def table_name
      'hoge'
    end

    def attributes
      [
        { type: 'int', name: 'price', constraint: nil },
        { type: 'string', name: 'name', constraint: nil }
      ]
    end
  end
end
