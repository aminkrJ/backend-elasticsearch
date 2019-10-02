module ElasticsearchClient
  class Config
   attr_accessor :host, :scheme, :user, :password

    def initialize
      default = YAML.load_file("#{Rails.root.to_s}/config/elasticsearch_client.yml")
      @password = default["password"]
      @scheme = default["scheme"]
      @host = default["host"]
      @user = default["user"]
    end

    def to_h
      {
        host: host,
        http: {
          scheme: scheme,
          user: user,
          password: password
        }
      }
    end
  end
end
