require 'pacio_inferno_core/must_support_test'

module PacioPFETestKit
  module PacioPFEV200
    class GoalMustSupportTest < Inferno::Test
      include PacioInfernoCore::MustSupportTest

      title 'All must support elements are provided in the Goal resources returned'

      description %(
        This test will look through the Goal resources
        found previously for the following must support elements:

        * Goal.achievementStatus
        * Goal.addresses
        * Goal.description
        * Goal.expressedBy
        * Goal.lifecycleStatus
        * Goal.note
        * Goal.startDate
        * Goal.subject
        * Goal.target
        * Goal.target.dueDate
      )

      id :pfe_v200_goal_must_support_test

      def resource_type
        'Goal'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:goal_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
