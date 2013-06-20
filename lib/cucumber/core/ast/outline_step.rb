require 'cucumber/core/ast/describes_itself'
require 'cucumber/core/ast/step'

module Cucumber
  module Core
    module Ast

      class OutlineStep
        include DescribesItself

        attr_reader :language, :location, :keyword, :name, :multiline_arg

        def initialize(language, location, keyword, name, multiline_arg=nil)
          @language, @location, @keyword, @name, @multiline_arg = language, location, keyword, name, multiline_arg
          @language || raise("Language is required!")
        end

        attr_reader :gherkin_statement
        def gherkin_statement(statement=nil)
          @gherkin_statement ||= statement
        end

        def to_step(row)
          Ast::Step.new(language, location, keyword, replace_name(row), replace_multiline_arg(row))
        end

        private

        def description_for_visitors
          :outline_step
        end

        def children
          []
        end

        def replace_name(row)
          @name = row.expand(name)
        end

        def replace_multiline_arg(row)
          multiline_arg
        end
      end

    end
  end
end

