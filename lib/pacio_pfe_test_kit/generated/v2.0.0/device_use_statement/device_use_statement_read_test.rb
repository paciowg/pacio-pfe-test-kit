require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class DeviceUseStatementReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct DeviceUseStatement resource from DeviceUseStatement read interaction'
      description 'A server SHOULD support the DeviceUseStatement read interaction.'

      id :pfe_v200_device_use_statement_read_test

      def resource_type
        'DeviceUseStatement'
      end

      def scratch_resources
        scratch[:device_use_statement_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'DeviceUseStatement'), delayed_reference: true)
      end
    end
  end
end
