# encoding: utf-8

require 'minitest/autorun'
require 'minitest/spec'

describe 'foreman::export' do
  it "creates the Init files" do
    %w{ my_app my_app-also my_app-also-1 my_app-test my_app-test-1 my_app-test-2 my_app-test-3 }.each do |config|
      init_file = ::File.join('/tmp/test/foreman',"#{config}.conf")
      assert ::File.exist?(init_file), "#{init_file} does not exist"
    end
  end
end
