class Config
    attr_accessor :data_path, :template_path

    def self.get
        @@active_config ||= self.build_config()
    end

    def self.build_config
        conf = Config.new

        if ENV["PHRASEGEN_DATA_PATH"].nil?
            puts "must provide PHRASEGEN_DATA_PATH in environment"
            exit 1
        end
        conf.data_path = ENV["PHRASEGEN_DATA_PATH"]

        if ENV["PHRASEGEN_TEMPLATE_PATH"].nil?
            puts "must provide PHRASEGEN_TEMPLATE_PATH in environment"
            exit 1
        end
        conf.template_path = ENV["PHRASEGEN_TEMPLATE_PATH"]

        conf
    end
end