APP_CONFIG = YAML::load(File.open("#{Rails.root}/config/config.yml"))[Rails.env]
