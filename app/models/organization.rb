class Organization < ApplicationRecord
  after_create do
    schema = self.name.parameterize.underscore
    self.update_column(:database, schema)
      
    unless Apartment.tenant_names.include?(schema)
      Apartment::Tenant.create(schema)
    end
  end       
end
