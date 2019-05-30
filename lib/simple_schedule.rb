require 'rufus-scheduler'
require 'logger'

module SimpleSchedule
  def run
    scheduler = Rufus::Scheduler.new

    jobs.each do |type, schedule, job|
      if job.respond_to?(:perform_later)
        scheduler.public_send(type, schedule) do
          logger.info { "Enqueueing #{job} to be performed later" }
          job.perform_later
        end
      elsif job.respond_to?(:perform)
        scheduler.public_send(type, schedule) do
          logger.info { "Performing #{job} synchronously" }
          job.perform
        end
      elsif job.instance_methods.include?(:perform)
        scheduler.public_send(type, schedule) do
          logger.info { "Performing #{job} synchronously" }
          job.new.perform
        end
      else
        raise ArgumentError.new("Job #{job} does not respond to #{job}.perform_async, #{job}.perform, or #{job}#perform")
      end
    end

    Signal.trap('INT') { scheduler.shutdown }
    Signal.trap('TERM') { scheduler.shutdown }

    scheduler.join
  end

  private

  def logger
    @logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def jobs
    @jobs ||= []
  end

  def once_in(interval, job)
    jobs << [:in, interval, job]
  end

  def once_at(time, job)
    jobs << [:at, time, job]
  end

  def every(interval, job)
    jobs << [:every, interval, job]
  end

  def interval(interval, job)
    jobs << [:interval, interval, job]
  end

  def cron(tab, job)
    jobs << [:cron, tab, job]
  end
end
