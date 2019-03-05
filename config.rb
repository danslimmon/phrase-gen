class Config
    attr_accessor :data_path, :views_dir

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

        if ENV["PHRASEGEN_VIEWS_DIR"].nil?
            puts "must provide PHRASEGEN_VIEWS_DIR in environment"
            exit 1
        end
        conf.views_dir = ENV["PHRASEGEN_VIEWS_DIR"]

        conf
    end
end
