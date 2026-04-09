require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioPFETestKit
  module PacioPFEV200
    class ConditionEncounterDiagnosisPatientClinicalStatusSearchTest < Inferno::Test
      include PacioPFETestKit::SearchTest

      title 'Server returns valid results for Condition search by patient + clinical-status'
      description %(
A server SHOULD support searching by
patient + clinical-status on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PACIO PFE Server CapabilityStatement](/CapabilityStatement-pfe.html)

      )

      id :pfe_v200_condition_encounter_diagnosis_patient_clinical_status_search_test
      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

      def self.properties
        @properties ||= PacioInfernoCore::SearchTestProperties.new(
          resource_type: 'Condition',
          search_param_names: ['patient', 'clinical-status'],
          token_search_params: ['clinical-status']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:condition_encounter_diagnosis_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
