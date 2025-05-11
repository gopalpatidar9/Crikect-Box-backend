namespace :tenant do
  desc "Create tenants, run migrations, and seed each schema"
  task setup: :environment do
    Organization.find_each do |org|
      schema = org.database.presence || org.name.parameterize.underscore
      next if schema.blank?
  
      unless Apartment.tenant_names.include?(schema)
        puts "Creating tenant schema for #{schema}"
        Apartment::Tenant.create(schema)
      end
  
     Apartment::Tenant.switch(schema) do
       puts "Migrating #{schema}..."
       ActiveRecord::Migrator.migrations_paths = ['db/migrate']
       ActiveRecord::MigrationContext.new('db/migrate', ActiveRecord::SchemaMigration).migrate
  
       puts "Seeding #{schema}..."
       # Add your seed logic here (or extract from db/seeds.rb)
     end
    end
  end
end
  