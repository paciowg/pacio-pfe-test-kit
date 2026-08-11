require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV300_BALLOT
    class ConditionEncounterDiagnosisReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct Condition resource from Condition read interaction'
      description 'A server SHALL support the Condition read interaction.'

      id :pfe_v300_ballot_condition_encounter_diagnosis_read_test

      def resource_type
        'Condition'
      end

      def scratch_resources
        scratch[:condition_encounter_diagnosis_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
