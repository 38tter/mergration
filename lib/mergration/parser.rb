# frozen_string_literal: true

require 'kramdown-mermaid/parser'

module Mergration
  class Parser
    def self.parse(path)
      raise "File does not exist: #{path}" unless File.exists?(path)
    end

    def document_hash_ast
      Kramdown::Document.new(text, input: 'KramdownErDiagram').to_hash_ast
    end

    def entities
      document_hash_ast[:children].select { |k, _| k[:type] == :entity }.map(&:options)
    end
  end
end
