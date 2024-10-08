require 'active_support/concern'

module Services
  module I18n
    module CurriculumSyncUtils
      module RenderTranslations
        extend ActiveSupport::Concern
        class_methods do
          # Helper method for retrieving I18N strings generated by
          # CurriculumSyncUtils::SyncOut. Specifically, the logic in this
          # method is a reflection of the CrowdinSerializer indexing logic
          # (default to using `object.key` as the key, but support overriding
          # that for specific models), as well as the SyncOut reorganization
          # logic (strings are organized by model type, then by model
          # identifier, then by property name).
          #
          # Will default to the relevant English string when appropriate.
          def get_localized_property(object, property_name, key = nil)
            key = object.key if key.blank?
            unlocalized_property = object.send(property_name)
            return unlocalized_property if ::I18n.locale == ::I18n.default_locale
            return ::I18n.t(
              property_name,
              scope: [:data, object.model_name.plural, key],
              default: unlocalized_property,
              smart: true
            )
          end
        end
      end
    end
  end
end
