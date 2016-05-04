require 'spec_helper'

describe "foreman_export create" do
  before do
  end

  let(:app_name) do
    'sample'
  end

  context 'upstart config' do
    let(:init_file) do
      "/etc/init/#{app_name}"
    end

    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        :step_into => %w( foreman_export )
      ).converge('test-foreman::upstart')
    end

    it "creates the Init files" do
      %w{ my_app my_app-also my_app-also-1 my_app-test my_app-test-1 my_app-test-2 my_app-test-3 }.each do |config|
        expect(chef_run).to render_file("#{config}.conf")
      end
    end
  end
end
