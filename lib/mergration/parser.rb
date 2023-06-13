# frozen_string_literal: true

require 'kramdown/document'
require 'kramdown-mermaid/parser'

module Mergration
  class Parser
    def self.parse(path)
      raise "File does not exist: #{path}" unless File.exist?(path)

      text = File.read(path)

      ast = Kramdown::Document.new(text, input: 'KramdownErDiagram').to_hash_ast
      ast[:children].select { |k, _| k[:type] == :entity }.map { |e| e[:options] }
    end
  end
end
