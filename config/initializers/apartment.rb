# frozen_string_literal: true

# You can have Apartment route to the appropriate Tenant by adding some Rack middleware.
# Apartment can support many different "Elevators" that can take care of this routing to your data.
# Require whichever Elevator you're using below or none if you have a custom one.
#
# require 'apartment/elevators/generic'
# require 'apartment/elevators/domain'
require 'apartment/elevators/subdomain'
# require 'apartment/elevators/first_subdomain'
# require 'apartment/elevators/host'

#
# Apartment Configuration
#
Apartment.configure do |config|
  
  config.tenant_names = -> { Organization.pluck :name }
   
end

# Rails.application.config.middleware.use Apartment::Elevators::Domain
Rails.application.config.middleware.use Apartment::Elevators::Subdomain
# Rails.application.config.middleware.use Apartment::Elevators::FirstSubdomain
# Rails.application.config.middleware.use Apartment::Elevators::Host
