require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class CollectionReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :pfe_v200_collection_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:collection_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
