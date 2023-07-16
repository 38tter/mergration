# frozen_string_literal: true

TestApp::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  config.cache_classes = true
  config.eager_load = false

  if config.respond_to?(:public_file_server)
    config.public_file_server.enabled = true
  elsif config.respond_to?(:serve_static_files=)
    config.serve_static_files = true
  else
    config.serve_static_assets = true
  end

  if config.respond_to?(:public_file_server)
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=3600"
    }
  else
    config.static_cache_control = "public, max-age=3600"
  end

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :stderr
end
