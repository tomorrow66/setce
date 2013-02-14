desc 'Loads the app into the standard development server'
task :server do
	exec 'ruby settings/application.rb'
end