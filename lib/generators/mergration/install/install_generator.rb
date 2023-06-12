# frozen_string_literal: true

require_relative '../migration_generator'

module Mergration
  class InstallGenerator < MigrationGenerator
    source_root File.expand_path('templates', __dir__)

    desc 'Generates a migration from entities described on mermaid.'

    def create_migration_file
      add_mergration_migration(
        'create_dummy_tables'
      )
    end
  end
end
