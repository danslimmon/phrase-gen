class Config
    attr_accessor :data_dir, :template_dir, :port

    def self.get
        @@active_config ||= self.build_config()
    end

    def self.build_config
        conf = Config.new

        if ENV["PHRASEGEN_DATA_DIR"].nil?
            puts "must provide PHRASEGEN_DATA_DIR in environment"
            exit 1
        end
        conf.data_dir = ENV["PHRASEGEN_DATA_DIR"]

        if ENV["PHRASEGEN_TEMPLATE_DIR"].nil?
            puts "must provide PHRASEGEN_TEMPLATE_DIR in environment"
            exit 1
        end
        conf.template_dir = ENV["PHRASEGEN_TEMPLATE_DIR"]

        if ENV["PORT"].nil?
            puts "must provide PORT in environment"
            exit 1
        end
        conf.port = ENV["PORT"]

        conf
    end
end
