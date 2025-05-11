class Organization < ApplicationRecord
    after_create :create_tenant

    def create_tenant
      schema_name = self.database.presence || name.parameterize.underscore
    
      # Set and persist the sanitized schema name
      self.update_column(:database, schema_name) if self.database.blank?
    
      # Avoid creation if schema already exists
      unless Apartment.tenant_names.include?(schema_name)
        Apartment::Tenant.create(schema_name)
      rescue Apartment::TenantExists
        Rails.logger.warn "Tenant #{schema_name} already exists"
      end
    end      
end
