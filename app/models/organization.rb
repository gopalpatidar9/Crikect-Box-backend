class Organization < ApplicationRecord
    after_create :create_tenant

    def create_tenant
      schema_name = name.parameterize.underscore  # Ensures no spaces or invalid chars
    
      unless Apartment.tenant_names.include?(schema_name)
        Apartment::Tenant.create(schema_name)
      else
        Rails.logger.info "Tenant #{schema_name} already exists"
      end
    end
    
    def database
      name.parameterize.underscore
    end
     
end
