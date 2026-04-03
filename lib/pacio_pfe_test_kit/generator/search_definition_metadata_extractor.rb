require 'pacio_inferno_core/generator/search_definition_metadata_extractor'

module PacioPFETestKit
  class Generator
    class SearchDefinitionMetadataExtractor < PacioInfernoCore::Generator::SearchDefinitionMetadataExtractor      
      def full_paths
        @full_paths ||=
          begin
            path = param.expression.gsub(/.where\(resolve\((.*)/, '').gsub('url = \'', 'url=\'')
            path = path[1..-2] if path.start_with?('(') && path.end_with?(')')
            path.scan(/[. ]as[( ]([^)]*)[)]?/).flatten.map do |as_type|
              path.gsub!(/[. ]as[( ](#{as_type}[^)]*)[)]?/, as_type.upcase_first) if as_type.present?
            end

            path.gsub!('Resource.', "#{resource}.") if path.start_with?('Resource.')

            full_paths = path.split('|')

            # There is a bug in US Core 5 asserted-date search parameter. See FHIR-40573
            if param.respond_to?(:version) && param.version == '5.0.1' && name == 'asserted-date'
              remove_additional_extension_from_asserted_date(full_paths)
            end

            full_paths
          end
      end
    end
  end
end
