namespace :import do
  desc "Import data about units fire brigades from xls file"
  task :fire_brigade_data, [:file_path] => [:environment] do |_task, args|
    path = args[:file_path]

    abort 'Not supported file type' if File.extname(path) != '.xls'
    abort 'File not found' unless File.exist?(path)

    spreadsheet = Roo::Spreadsheet.open(path)
    fire_brigades = []
    keys = FireBrigade.column_names[1..-1]

    (2..spreadsheet.last_row).each do |index|
      attributes = Hash[keys.zip spreadsheet.row(index)]
      fire_brigades << FireBrigade.new(attributes)
    end

    FireBrigade.transaction do
      fire_brigades.each(&:save)
    end
  end

end
