module Databases
  class ImportAges < ApplicationService
    def call
      import_age
    end

    private

    def import_age
      age_file = Rails.root.join("lib/databases/age.xlsx")

      raise "Age file not found" unless File.exist?(age_file)

      age_xlsx = Roo::Excelx.new(age_file)
      age_xlsx.each_row_streaming(offset: 1) do |row|
        cells = row.map(&:value)
        age =  { age: cells[1], multiplier: cells[2] }

        begin
          Age.create!(age)
        rescue ActiveRecord::RecordInvalid => e
          puts "Error: #{e.message}"
        end
      end
    end
  end
end
