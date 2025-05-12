class Organization < ApplicationRecord
    after_create :create_tenant
  
    def create_tenant
      schema_name = self.database.presence
      self.update_column(:database, schema_name) if self.database.blank?
  
      begin
        unless Apartment.tenant_names.include?(schema_name)
          Apartment::Tenant.create(schema_name)
        else
          Rails.logger.info "Tenant #{schema_name} already exists"
        end
      rescue Apartment::TenantExists => e
        Rails.logger.warn "Tenant creation failed for #{schema_name}: #{e.message}"
      end
    end
end
  