require "pathname"

require "vagrant-ssh-provider/plugin"

module VagrantPlugins
  module SshProvider
    lib_path = Pathname.new(File.expand_path("../vagrant-ssh-provider", __FILE__))

    def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
    end
  end
end