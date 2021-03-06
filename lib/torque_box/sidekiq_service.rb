require File.expand_path('../../torquebox-sidekiq-service', __FILE__)

module TorqueBox
  class SidekiqService
    attr_accessor :config, :launcher, :start_failed

    CONFIG_OPTIONS_TO_STRIP = [:config_file, :daemon, :environment, :pidfile, :require, :tag]

    def initialize(opts = {})
      @l = TorqueBox::Logger.new('sidekiq_init')
      @l.info opts
      opts =  Hash[opts.map{|k,v| [:"#{k}",v] }]
      @l.info opts
      setup_redis(opts.delete(:redis))

      @config = opts.reject { |k, _| CONFIG_OPTIONS_TO_STRIP.include?(k) }
      @l.info @config
      @mutex = Mutex.new
    end

    def start
      Thread.new { @mutex.synchronize { run } }
    end

    def stop
      @mutex.synchronize { launcher.stop } if launcher
    end

    def run
      Sidekiq.options.merge!(config)
      Sidekiq.options[:queues] << 'default' if Sidekiq.options[:queues].empty?
      @l.info Sidekiq.options
      if Sidekiq.options.has_key?(:logfile)
        Sidekiq::Logging.initialize_logger(Sidekiq.options[:logfile])
      else
        Sidekiq::Logging.logger = TorqueBox::Logger.new('sidekiq') if ENV.has_key?('TORQUEBOX_CONTEXT')
      end

      if Sidekiq.options.has_key?(:verbose)
        Sidekiq.logger.level = Logger::DEBUG
        Celluloid.logger = Sidekiq.logger
      end

      require 'sidekiq/launcher'

      @launcher = Sidekiq::Launcher.new(Sidekiq.options)

      launcher.run
    rescue => e
      puts e.message
      puts e.backtrace

      @start_failed = true
    end

  private

    def setup_redis(opts)
      Sidekiq.redis = Hash[opts.map{|k,v| [:"#{k}",v] }] if opts
    end
  end
end
