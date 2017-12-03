require "log4r"
require "vagrant"

module VagrantPlugins
  module SshProvider
    class Provider < Vagrant.plugin("2", :provider)
      def initialize(machine)
        require 'net/ssh'
        @machine = machine
        @logger  = Log4r::Logger.new("vagrant::provider::ssh")
        puts machine.to_s
        puts machine.id.to_s
        pc = @machine.provider_config[:ssh]
        puts pc.to_s
        @ssh = Net::SSH::start(pc[:host], pc[:username])
      end

      def action(name)
        action_method = "action_#{name}"
        nil
      end

      def ssh_info
        # Run a custom action called "read_ssh_info" which does what it
        # says and puts the resulting SSH info into the `:machine_ssh_info`
        # key in the environment.
        env[:ui].info("called read_ssh_info")
        env = @machine.action("read_ssh_info", lock: false)
        env[:machine_ssh_info]
      end

      def state
        # Run a custom action we define called "read_state" which does
        # what it says. It puts the state in the `:machine_state_id`
        # key in the environment.
        env = @machine.action("read_state", lock: false)

        state_id = env[:machine_state_id]

        # Get the short and long description
        short = I18n.t("vagrant_aws.states.short_#{state_id}")
        long  = I18n.t("vagrant_aws.states.long_#{state_id}")

        # Return the MachineState object
        Vagrant::MachineState.new(state_id, short, long)
      end

      def to_s
        id = @machine.id.nil? ? "new" : @machine.id
        "SshProvider (#{id})"
      end
    end
  end
end
