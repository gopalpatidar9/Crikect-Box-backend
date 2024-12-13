class Organization < ApplicationRecord
#   after_create do
#     organization_name = self.name
#     organization_name = organization_name.gsub(" ", "_")
#     Apartment::Tenant.create(name: organization_name)
#   end
end
