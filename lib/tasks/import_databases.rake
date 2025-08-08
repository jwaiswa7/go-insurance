namespace :import_databases do
  desc "Import database records from excel files"
  task all: :environment do
    Databases::ImportConfigs.call
    Databases::ImportAges.call
    Databases::ImportDestinations.call
  end
end
