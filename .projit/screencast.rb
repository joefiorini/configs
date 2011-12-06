in_project_root do
  empty_directory project
end

project_dirs = %w(artwork export film releases script)


in_project_directory do
  project_dirs.each { |d| empty_directory d }
end

create_link_in_dropbox project_base
