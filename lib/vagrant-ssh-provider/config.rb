require "vagrant"

module VagrantPlugins
  module SshProvider
    class Config < Vagrant.plugin("2", :config)
      attr_reader :ssh
      attr_accessor :provider
      
      def initialize()
        @ssh = VagrantPlugins::Kernel_V2::SSHConfig.new
      end
    end
  end
end
