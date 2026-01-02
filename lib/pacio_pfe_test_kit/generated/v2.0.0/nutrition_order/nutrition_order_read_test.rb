require_relative '../../../read_test'

module PacioPFETestKit
  module PacioPFEV200
    class NutritionOrderReadTest < Inferno::Test
      include PacioPFETestKit::ReadTest

      title 'Server returns correct NutritionOrder resource from NutritionOrder read interaction'
      description 'A server SHOULD support the NutritionOrder read interaction.'

      id :pfe_v200_nutrition_order_read_test

      def resource_type
        'NutritionOrder'
      end

      def scratch_resources
        scratch[:nutrition_order_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'NutritionOrder'), delayed_reference: true)
      end
    end
  end
end
