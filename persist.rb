require 'json'

class Persist
    attr_reader :path_name
    def initialize(path_name)
        @path_name = path_name
    end

    def save(data)
        data_to_save = JSON.pretty_generate(data)
        File.write(path_name, data_to_save.to_s)
    end

    def load
        data_to_load = File.read(@path_name)
        JSON.parse(data_to_load)
    end
end
