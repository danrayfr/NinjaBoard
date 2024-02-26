module BuildAssociation
  extend ActiveSupport::Concern

  included do
    def build_association_if_missing(model)
      return if send(model).present?

      # Create a new instance of the specified model and associate it with self
      send("build_#{model}").save
    end
  end
end
