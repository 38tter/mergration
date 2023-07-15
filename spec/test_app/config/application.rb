# frozen_string_literal: true
require File.expand_path("boot", __dir__)

module TestApp
  class Application < Rails::Application
    YAML_COLUMN_PERMITTED_CLASSES = [
      ::ActiveRecord::Type::Time::Value,
      ::ActiveSupport::TimeWithZone,
      ::ActiveSupport::TimeZone,
      ::BigDecimal,
      ::Date,
      ::Symbol,
      ::Time
    ].freeze

    config.load_defaults(::ActiveRecord.gem_version.segments.take(2).join("."))

    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_support.test_order = :sorted
    config.secret_key_base = "A fox regularly kicked the screaming pile of biscuits."

    ::ActiveRecord::Base.use_yaml_unsafe_load = false
    ::ActiveRecord::Base.yaml_column_permitted_classes = YAML_COLUMN_PERMITTED_CLASSES
  end
end
