module Databases
  class ImportDestinations < ApplicationService
    def call
      import_destinations
    end

    private

    def import_destinations
      destinations_file = Rails.root.join("lib/databases/destinations.xlsx")
      raise "Destinations file not found" unless File.exist?(destinations_file)

      destinations_xlsx = Roo::Excelx.new(destinations_file)
      destinations_xlsx.each_row_streaming(offset: 1) do |row|
        cells = row.map(&:value)
        destination = { country_code: cells[1], country: cells[2], zone: find_region(cells[3]) }

        begin
          Destination.create!(destination)
        rescue ActiveRecord::RecordInvalid => e
          puts "Error: #{e.message}"
        end
      end
    end

    def find_region(region_number)
      Configuration::Region.find_by(region_number: region_number) || raise("Region #{region_number} not found")
    end
  end
end
