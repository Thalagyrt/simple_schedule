Gem::Specification.new do |s|
  s.name        = 'simple_schedule'
  s.version     = '0.0.2'
  s.date        = '2018-04-21'
  s.summary     = "A simple scheduler for jobs"
  s.description = "A simple scheduler for jobs built around rufus_scheduler"
  s.authors     = ["James Riley"]
  s.email       = 'jriley@jamespriley.com'
  s.files       = ["lib/simple_schedule.rb"]
  s.homepage    =
    'https://github.com/thalagyrt/simple_schedule'
  s.license       = 'MIT'
  s.add_runtime_dependency(%q<rufus-scheduler>, ['~> 3.0.0'])
end
