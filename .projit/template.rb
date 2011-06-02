in_project_root do
  empty_directory project
end

project_dirs = %w(source docs/coverage docs/yard artifacts rvm_hooks vendor)

in_project_directory do
  project_dirs.each { |d| empty_directory d }

  inside "rvm_hooks" do
    create_file "after_use", <<-EOF
# This is your project's after_use hook. Use it to add initialization tasks
# that you want to run when you switch contexts to this project. For example,
# you could use this task to start services only needed by this project (e.g.
# memcached, mysql, etc.).
EOF
  end
end

create_link_in_dropbox project_base

clone_from_github_into 'source'
