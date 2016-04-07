require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true

desc 'Validate manifests, templates, and ruby files'
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

PuppetLint::RakeTask.new :lint do |config|
  # Pattern of files to check, defaults to `**/*.pp`
  config.pattern = 'manifests/**/*.pp'

  # Should the task fail if there were any warnings, defaults to false
  config.fail_on_warnings = true

  # Format string for puppet-lint's output (see the puppet-lint help output
  # for details
  config.log_format = '%{filename} - %{message}'

  # Print out the context for the problem, defaults to false
  config.with_context = true

  # Enable automatic fixing of problems, defaults to false
  config.fix = true

  # Show ignored problems in the output, defaults to false
  config.show_ignored = false

  # Compare module layout relative to the module root
  config.relative = true
end
