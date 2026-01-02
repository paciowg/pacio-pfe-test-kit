require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class PatientReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :pfe_v200_patient_read_test

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
