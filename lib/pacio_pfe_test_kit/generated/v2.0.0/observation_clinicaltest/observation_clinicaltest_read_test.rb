require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class ObservationClinicaltestReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :pfe_v200_observation_clinicaltest_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:observation_clinicaltest_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
