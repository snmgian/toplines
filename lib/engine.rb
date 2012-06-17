require 'data_mapper'
require 'dm-migrations'
require 'yaml'

module G
  class Engine

    DEFAULT_ENVIRONMENT = 'development'

    attr_accessor :environment

    def initialize(environment = nil)
      @environment = (environment || ENV['G_ENV'] || DEFAULT_ENVIRONMENT).to_sym
      @plugins = []
      self.register(G::GPlugin)
      self.instance_eval(File.read('g.rb'))
    end

    def register(plugin)
      @plugins << plugin.new
    end

    def run
      self.load_configuration
      self.auto_require

      @plugins.each do |plugin|
        plugin.run(self.environment, @configuration)
      end
    end

    def auto_require
      @plugins.each(&:auto_require)
    end

    def load_configuration
      base_path = "config/#{@environment}"

      @configuration = {}
      @plugins.each do |plugin|
        @configuration.merge!(plugin.load_configuration(base_path))
      end
    end
  end
end

module G
  class AbstractPlugin

    def auto_require
      paths = auto_require_paths

      paths.each do |path|
        Dir["#{path}/**/*.rb"].each {|f| require f}
      end
    end

    def auto_require_paths
      []
    end

    def configurations
      []
    end

    def load_configuration(base_path)
      conf = {}

      conf_files = self.configurations

      conf_files.each do |conf_file|
        conf_name = self.configuration_name(conf_file)
        conf[conf_name.to_sym] = YAML.load_file("#{base_path}/#{conf_file}")
      end

      conf
    end

    def configuration_name(configuration_file)
      configuration_file.gsub(/\.yml$/, '')
    end

    def run(environment, configuration); end
  end
end

module G
  class GPlugin < AbstractPlugin
    def auto_require_paths
      [
        'business',
        'exceptions',
        'models',
        'web',
      ]
    end
  end
end

module G
  class DataMapperPlugin < AbstractPlugin

    def configurations
      ["database.yml"]
    end

    def run(environment, configuration)
      DataMapper::Logger.new($stdout, :debug)

      DataMapper.finalize

      DataMapper.setup(:default, configuration[:database]['connection_url'])

      if environment == :test
        DataMapper.auto_migrate!
      else
        DataMapper.auto_upgrade!
      end
    end
  end
end
