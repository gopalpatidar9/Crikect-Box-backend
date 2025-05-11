namespace :tenant do
    desc "Create tenants, run migrations, and seed each schema"
    task setup: :environment do
      require 'active_record/tasks/database_tasks'
  
      Organization.find_each do |org|
        schema = org.database.presence || org.name.parameterize.underscore
        next if schema.blank?
  
        if Apartment.tenant_names.exclude?(schema)
          puts "Creating tenant schema for '#{schema}'..."
          Apartment::Tenant.create(schema)
        else
          puts "Tenant schema '#{schema}' already exists. Skipping creation."
        end
  
        Apartment::Tenant.switch(schema) do
          puts "Migrating schema '#{schema}'..."
  
          migration_paths = ActiveRecord::Migrator.migrations_paths
          migration_context = if ActiveRecord::VERSION::MAJOR >= 6
                                ActiveRecord::MigrationContext.new(migration_paths, ActiveRecord::SchemaMigration)
                              else
                                ActiveRecord::MigrationContext.new(migration_paths)
                              end
  
          migration_context.migrate
  
          puts "Seeding schema '#{schema}'..."
          # You can either call a custom seed file per tenant:
          # load Rails.root.join('db/seeds/tenant.rb')
          #
          # Or reuse the default seed file:
          load Rails.root.join('db/seeds.rb')
        end
      end
    end
  end
  