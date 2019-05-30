# Simple Schedule

A simple scheduler DSL built around making the lovely `rufus-scheduler` a bit
easier to use in certain situations.

## Example

```ruby
require 'simple_schedule'

class MyJob
  def perform
    puts "running my job!"
  end
end

module Schedule
  extend SimpleSchedule

  once_in '1s', MyJob
  every '5m', MyJob
end

Schedule.run
```

The available DSL methods are `once_in`, `once_at`, `every`, `interval`, and `cron`.
For more information on each of these methods, please see the `rufus-scheduler` gem
at https://github.com/jmettraux/rufus-scheduler

`once_in` and `once_at` are aliases for `in` and `at` in `rufus-scheduler` respectively.

How you start the schedule is up to you. It's meant to be run in its own process,
so you may want to run your schedule in a long-running rake task that you run
one and only one of.

Jobs are expected to either respond to the class methods `perform_later` or `perform`,
or the instance method `perform`. We'll use them in that order, so this will just work
with ActiveJobs, provided the job takes no arguments.

The reason this does not take lambdas is to encourage all work to be done in a
background worker instead of in the scheduler. The scheduler's job is purely to
enqueue work to be done elsewhere.
