# frozen_string_literal: true

require 'singleton'
require 'yaml'

class Config
  include Singleton

  def initialize
    config
  end

  def valid?
    valid
  end

  def output_path
    @output_path ||= File.expand_path config[:output_path]
  end

  def output_file
    @output_file ||= File.join output_path, config[:output_file]
  end

  def input_file
    @input_file ||= File.join output_path, config[:output_file]
  end

  def method_missing(method_name, *arguments, &block)
    if config.key? method_name
      config[method_name]
    else
      super
    end
  end

  def respond_to_missing?(method_name, _include_private = false)
    config.key? method_name
  end

  private

  attr_reader :valid, :yaml_data, :config_file_path

  def config
    return yaml_data if yaml_data
    @config_file_path = config_file unless config_file_path
    @yaml_data ||= YAML.load_file config_file
    @valid = true
    @yaml_data
  rescue Errno::ENOENT
    @valid = false
    {}
  end

  def config_file
    return ENV['CONFIG_PATH'] if ENV['CONFIG_PATH']
    'config.yml'
  end
end
