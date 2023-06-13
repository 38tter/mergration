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
        'create_dummy_tables'
      )
    end

    def parse_file
      files = Dir.glob(File.expand_path('docs/mermaid/*.md'))

      results = []
      files.each do |file|
        results << Mergration::Parser.parse(file)
      end
      results
    end
  end
end
