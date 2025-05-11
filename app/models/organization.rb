class Organization < ApplicationRecord
  after_create :create_tenant

  def create_tenant
    schema_name = self.database.presence || name.parameterize.underscore
    self.update_column(:database, schema_name) unless self.database.present?

    unless Apartment.tenant_names.include?(schema_name)
      Apartment::Tenant.create(schema_name)
    else
      Rails.logger.info "Tenant #{schema_name} already exists"
    end
  end
     
end
