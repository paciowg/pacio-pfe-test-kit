require 'pacio_inferno_core/must_support_test'

module PacioPFETestKit
  module PacioPFEV200
    class ObservationSingleMustSupportTest < Inferno::Test
      include PacioInfernoCore::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'

      description %(
        This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:PFEDomain
        * Observation.category:survey
        * Observation.category:us-core
        * Observation.code
        * Observation.effectiveDateTime
        * Observation.extension:device-use
        * Observation.extension:event-location
        * Observation.method
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.valueBoolean
        * Observation.valueCodeableConcept
        * Observation.valueQuantity
        * Observation.valueString
      )

      id :pfe_v200_observation_single_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_single_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
