require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV300
    class DeviceRequestReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct DeviceRequest resource from DeviceRequest read interaction'
      description 'A server SHALL support the DeviceRequest read interaction.'

      id :pfe_v300_device_request_read_test

      def resource_type
        'DeviceRequest'
      end

      def scratch_resources
        scratch[:device_request_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
