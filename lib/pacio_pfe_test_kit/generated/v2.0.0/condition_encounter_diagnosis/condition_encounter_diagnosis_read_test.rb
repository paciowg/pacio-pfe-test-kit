require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class ConditionEncounterDiagnosisReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct Condition resource from Condition read interaction'
      description 'A server SHOULD support the Condition read interaction.'

      id :pfe_v200_condition_encounter_diagnosis_read_test

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
