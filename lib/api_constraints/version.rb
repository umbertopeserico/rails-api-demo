module ApiConstraints

  class Version

    def initialize(options)
      @version = options[:version]
      @default = options[:default]
    end

    def matches?(req)
      @default || req.headers['Accept'] =~ regex
    end

    private

    def format_version
      if @version.instance_of?(Array)
        @version.join(',')
      else
        @version
      end
    end

    def regex
      /application\/vnd.rails-api-demo.v[#{format_version}]\+json/
    end

  end

end