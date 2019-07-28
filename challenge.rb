# frozen_string_literal: true

env = ENV.fetch('APP_ENV') { 'development' }
passphrase = ENV.fetch('APP_PASSPHRASE') { 'Kans4s-i$-g01ng-by3-bye' }

require 'rubygems'
require 'bundler'
Bundler.require(:default, env.to_sym)
Dir[File.join(__dir__, 'lib', '**', '*.rb')].each { |file| require file }

# enable this for zion connection debugging
# connection = ZionConnection.new(passphrase, $stdout)

connection = ZionConnection.new(passphrase)
%w[sentinels sniffers loopholes].each do |source|
  Terminal.open(connection).start_tracer_for(source)
end
