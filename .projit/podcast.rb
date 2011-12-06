create_project_directory

project_subdirs %w(artifacts artifacts/originals artifacts/episodes docs site)

create_project_subdirs

create_link_in_dropbox File.join(project_base, 'artifacts')

directory 'octocast', project_path.join('site')
