require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioPFETestKit
  module PacioPFEV200
    class GoalLifecycleStatusSearchTest < Inferno::Test
      include PacioPFETestKit::SearchTest

      title 'Server returns valid results for Goal search by lifecycle-status'
      description %(
A server SHALL support searching by
lifecycle-status on the Goal resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PACIO PFE Server CapabilityStatement](/CapabilityStatement-pfe.html)

      )

      id :pfe_v200_goal_lifecycle_status_search_test
      def self.properties
        @properties ||= PacioInfernoCore::SearchTestProperties.new(
          resource_type: 'Goal',
          search_param_names: ['lifecycle-status']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:goal_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
