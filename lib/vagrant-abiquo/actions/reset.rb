require 'vagrant-abiquo/helpers/client'
require 'vagrant-abiquo/helpers/abiquo'

module VagrantPlugins
  module Abiquo
    module Actions
      class Reset
        include Helpers::Client
        include Helpers::Abiquo
        include Vagrant::Util::Retryable

        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @client = AbiquoAPI.new(@machine.provider_config.abiquo_connection_data)
          @logger = Log4r::Logger.new('vagrant::abiquo::reset')
        end

        def call(env)
          env[:ui].info I18n.t('vagrant_abiquo.info.reloading')
          vm = get_vm(@machine.id)
          vm = reset(vm)
          @app.call(env)
        end
      end
    end
  end
end


