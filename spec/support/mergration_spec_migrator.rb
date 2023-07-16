# See. https://github.com/paper-trail-gem/paper_trail/blob/3f0e3aba2e572b0bb88adc6e9bcfee67b2fcffcc/spec/support/paper_trail_spec_migrator.rb#L16-L15
require 'active_support'
require "active_record"

class MergrationSpecMigrator
  def initialize
    @migration_path = test_app_migrations_dir
  end

  def migrate
    ::ActiveRecord::MigrationContext.new(
      @migrations_path,
      ::ActiveRecord::Base.connection.schema_migration
    ).migrate
  end

  private

  def test_app_migrations_dir
    Pathname.new(File.expand_path("../test_app/db/migrate", __dir__))
  end
end
