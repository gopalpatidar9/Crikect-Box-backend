class Organization < ApplicationRecord
  after_create do
    schema_name = self.name.parameterize.underscore
    update_column(:database, schema_name)
    Apartment::Tenant.create(schema_name)
  end      
end
