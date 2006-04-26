class CalendarStylesGenerator < Rails::Generator::Base  

  def manifest
    record do |m|
      calendar_themes_dir = "public/stylesheets/calendar"
      m.directory calendar_themes_dir

      # TODO Copy stylesheets and images, recursively
      m.directory File.join(calendar_themes_dir, "red")
      m.file File.join("red/style.css"), File.join(calendar_themes_dir, "red/style.css")

      # Dir.read("vendor/public/calendar_helper/generators/calendar_styles/templates").each do |dir|
#         m.file "orig", File.join(calendar_themes_dir, dir.name, "some_file.css")
#       end

    end
  end
end
