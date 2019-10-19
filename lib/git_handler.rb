# frozen_string_literal: true

require 'fileutils'
require 'open3'

class GitHandler
  class Error < StandardError
    attr_reader :thing

    def initialize(output)
      msg = caller_locations((1..1)).first.path +
            " - something went wrong processing: #{output}"

      super(msg)
    end
  end

  attr_reader :repo_url, :local_path

  def initialize(url, path)
    @repo_url = url
    @local_path = path
  end

  def fetch_and_update_repo!
    output, process =
      if File.exist?(local_path)
        Open3.capture2e("cd #{local_path} && git pull")
      else
        FileUtils.mkdir_p(local_path)
        Open3.capture2e("git clone #{repo_url} #{local_path}")
      end

    return if process.success?

    raise Error, output
  end
end
