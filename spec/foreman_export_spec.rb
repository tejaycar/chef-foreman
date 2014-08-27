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
      ChefSpec::Runner.new(
        :step_into => %w( foreman_export ),
        :log_level => :debug
      ).converge('test-foreman::upstart')
    end

    it "creates the Init files" do
      expect(chef_run).to render_file(init_file)
    end
  end
end
