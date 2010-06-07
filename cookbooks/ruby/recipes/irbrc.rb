#
# Cookbook Name:: ruby
# Recipe:: irbrc
#

{ 'wirble'        => '0.3.1',
  'awesome_print' => '0.2.0',
  'hirb'          => '0.3.2',
  'what_methods'  => '1.0.1',
  'looksee'       => '0.2.1',
  'sketches'      => '0.1.1',
  'net-http-spy'  => '0.2.1',
  'map_by_method' => '0.8.3'
  }.each do |name, version|
  script "installed #{name}(#{version}) to liven up your ~/.irbrc a little" do
    interpreter "bash"
    code <<-EOS
      source ~/.cider.profile
      `gem list #{name} | grep -q '#{version}'`
      if [[ $? -ne 0 ]]; then
        gem install #{name} --no-rdoc --no-ri
      fi
    EOS
  end
end

template "#{ENV['HOME']}/.irbrc" do
  source "dot.irbrc.erb"
end
