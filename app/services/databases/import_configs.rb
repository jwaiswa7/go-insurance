module Databases
  class ImportConfigs < ApplicationService
    BASE_CONFIGS_SHEET = "Base "
    REGIONS_SHEET = "Region"
    DURATIONS_SHEET = "Duration"
    COVERS_SHEET = "Level of Cover"
    EXCESS_SHEET = "Excess"
    SCHEME_TYPES_SHEET = "Scheme Type"
    CRUISES_SHEET = "Cruise"
    SNOWS_SHEET = "Snow"

    SHEET_MAPPING = {
      BASE_CONFIGS_SHEET => Configuration::BaseConfig,
      REGIONS_SHEET => Configuration::Region,
      DURATIONS_SHEET => Configuration::Duration,
      COVERS_SHEET => Configuration::Cover,
      EXCESS_SHEET => Configuration::Excess,
      SCHEME_TYPES_SHEET => Configuration::SchemeType,
      CRUISES_SHEET => Configuration::Cruise,
      SNOWS_SHEET => Configuration::Snow
    }


    def call
      import_configs
    end

    private

    def configs_file
      config_file = Rails.root.join("lib/databases/config_tables.xlsx")
      raise "Configs file not found" unless File.exist?(config_file)
      config_file
    end

    def configs_xlsx
      @configs_xlsx ||= Roo::Excelx.new(configs_file)
    end

    def import_configs
      SHEET_MAPPING.each do |sheet_name, model|
        configs_xlsx.sheet(sheet_name).each_row_streaming(offset: 1) do |row|
          cells = row.map(&:value)
          next if cells.all?(&:nil?)

          record = map_config(cells, sheet_name)
          begin
            model.create!(record)
          rescue ActiveRecord::RecordInvalid => e
            puts "Error: #{e.message}"
          end
        end
      end
    end

    def map_config(cells, sheet_name)
      case sheet_name
      when BASE_CONFIGS_SHEET
        { base_number: cells[1] }
      when REGIONS_SHEET
        { region_number: cells[0], multiplier: cells[1] }
      when DURATIONS_SHEET
        { minimum: cells [2], multiplier: cells[3] }
      when COVERS_SHEET
        { level: cells[0], multiplier: cells[1] }
      when EXCESS_SHEET
        { excess_cents: cells[1] * 100, multiplier: cells[2] }
      when SCHEME_TYPES_SHEET
        { one_way: cells[1] == "Yes", multiplier: cells[2] }
      when CRUISES_SHEET
        { region: find_region(cells[1]), amount_cents: cells[2] * 100 }
      when SNOWS_SHEET
        { region: find_region(cells[0]), amount_cents: cells[1] * 100 }
      end
    end

    def find_region(region_number)
      Configuration::Region.find_by(region_number: region_number) || raise("Region #{region_number} not found")
    end
  end
end
