require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class DiagnosticReportReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct DiagnosticReport resource from DiagnosticReport read interaction'
      description 'A server SHALL support the DiagnosticReport read interaction.'

      id :pfe_v200_diagnostic_report_read_test

      def resource_type
        'DiagnosticReport'
      end

      def scratch_resources
        scratch[:diagnostic_report_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
