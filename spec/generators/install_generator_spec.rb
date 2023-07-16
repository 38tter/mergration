require "spec_helper"
require "generator_spec/test_case"
require "generators/mergration/install/install_generator"

RSpec.describe Mergration::InstallGenerator, type: :generator do
  include GeneratorSpec::TestCase
  destination File.expand_path("tmp", __dir__)

  after do
    prepare_destination
  end

  describe 'with no options' do
    let(:tempfile) {  Rails.root.join('docs/mermaid/er.md') }

    before do
      prepare_destination
      allow(Dir).to receive(:glob).and_call_original
      allow(Dir).to receive(:glob).with(File.expand_path('docs/mermaid/*.md')).and_return([tempfile])
      run_generator
    end

    it 'generates migration files' do
      expected_parent_class = lambda {
        old_school = "ActiveRecord::Migration"
        ar_version = ActiveRecord::VERSION
        format("%s[%d.%d]", old_school, ar_version::MAJOR, ar_version::MINOR)
      }.call
      expect(destination_root).to(
        have_structure do
          directory("db") do
            directory("migrate") do
              migration("create_hoges") do
                contains("class CreateHoges < " + expected_parent_class)
                contains "def change"
                contains "create_table :hoges do |t|"
                contains "t.bigint :id"
              end
              migration("create_fugas") do
                contains("class CreateFugas < " + expected_parent_class)
                contains "def change"
                contains "create_table :fugas do |t|"
                contains "t.bigint :id"
              end
            end
          end
        end
      )
    end
  end
end
