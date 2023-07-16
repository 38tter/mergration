# frozen_string_literal: true

require 'kramdown'
require 'kramdown-mermaid/parser'

module Mergration
  class ParseError < StandardError; end

  class Parser
    DOCUMENT_INPUT = 'KramdownMermaid'

    def self.parse(path)
      raise Mergration::ParseError, "File does not exist: #{path}" unless File.exist?(path)

      text = File.read(path)

      ast = Kramdown::Document.new(text, input: DOCUMENT_INPUT).to_hash_ast
      ast[:children].select { |k, _| k[:type] == :entity }.map
    end
  end
end
