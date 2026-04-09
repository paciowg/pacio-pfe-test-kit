require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class ServiceRequestReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct ServiceRequest resource from ServiceRequest read interaction'
      description 'A server SHOULD support the ServiceRequest read interaction.'

      id :pfe_v200_service_request_read_test

      def resource_type
        'ServiceRequest'
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
