require 'pacio_inferno_core/must_support_test'

module PacioPFETestKit
  module PacioPFEV200
    class ConditionEncounterDiagnosisMustSupportTest < Inferno::Test
      include PacioInfernoCore::MustSupportTest

      title 'All must support elements are provided in the Condition resources returned'

      description %(
        This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.abatementDateTime
        * Condition.asserter
        * Condition.bodySite
        * Condition.category
        * Condition.category:us-core
        * Condition.clinicalStatus
        * Condition.code
        * Condition.encounter
        * Condition.extension:assertedDate
        * Condition.onsetDateTime
        * Condition.recordedDate
        * Condition.subject
        * Condition.verificationStatus
      )

      id :pfe_v200_condition_encounter_diagnosis_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:condition_encounter_diagnosis_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
